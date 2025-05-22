import pandas as pd
import numpy as np
import csv

# Create a material property file for each individual fracture.

print(
    "\n********************************************\n"
    "Step 1: write_txt_for_3D_fracture_mesher.py\n"
    "Step 2: dfn_well_intersections.py  \n"
    "Step 3: write_diracs_input.py \n"
    "Step 4: write_nl_frac_materials_input.py or write_constant_frac_materials_input.py \n"
    "********************************************\n"
)

# Define the precision you want
precision = 10

# Read the CSV file
output_dir = "../simulation_inputs/"
fname = "../aleta_dfn/dfn_2025_03_14/27fracs.csv"


df = pd.read_csv(fname)

# correct Aleta's plunge direction for Andys gmsh script
df["Plunge[deg]"] = df["Plunge[deg]"]  # FIXME  DON"T FORGET THIS!!!


############ WRITE DIRAC KERNELS
with open(f"{output_dir}/fracture_materials_constant.i", "w") as file:
    file.write("# created by write_frac_materials_input.py\n")
    file.write("# DFN from fname \n")
    all_frac_block_id_string = '"'
    # creating string with all fracture block names in it.  Naming is from write_txt_for_3D_fracture_mesher.py
    for index in range(len(df)):
        all_frac_block_id_string += f"fracture{index+1} "
    all_frac_block_id_string += '"'
    file.write(f"all_frac_ids = {all_frac_block_id_string}\n\n")

    for index in range(len(df)):
        file.write(f"poro_fracture{index + 1} = ${{frac_poro}}\n")
    file.write("\n")
    for index in range(len(df)):
        file.write(f"perm_fracture{index + 1} = ${{frac_perm}}\n")
    file.write("\n")

    file.write("\n[Materials]\n")
    # porosity properties
    for index, row in df.iterrows():
        x = row["FractureX[m]"]
        y = row["FractureY[m]"]
        z = row["FractureZ[m]"]
        poro_frac_name = "{poro_fracture" + str(index + 1) + "}"
        l1 = f"  [porosity_fracture{int(index+1)}]"
        l2 = f"    type = PorousFlowPorosityConst"
        l3 = f"    porosity = ${poro_frac_name}"
        l4 = f"    block = fracture{index+1}"
        l5 = f"  []"
        file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n")
    # permeability properties
    for index, row in df.iterrows():
        perm_frac_name = "{perm_" + "fracture" + str(index + 1) + "}"
        l1 = f"  [permeability_fracture{int(index+1)}]"
        l2 = f"    type = PorousFlowPermeabilityConst"
        l3 = f"    permeability = '${perm_frac_name} 0 0 0 ${perm_frac_name} 0 0 0 ${perm_frac_name}'"
        l4 = f"    block = fracture{index+1}"
        l5 = f"  []"
        file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n")

    file.write("\n")
    # rock_internal_energy_fracture properties
    l1 = f"  [rock_internal_energy_fracture]"
    l2 = f"    type = PorousFlowMatrixInternalEnergy"
    l3 = f"    density = 2500"
    l4 = f"    specific_heat_capacity = 100.0"
    l5 = f"    block = ${{all_frac_ids}}"
    l6 = f"  []"
    file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n" + l6 + "\n")
    file.write("\n")
    # thermal_conductivity_fracture properties
    l1 = f"  [thermal_conductivity_fracture]"
    l2 = f"    type = PorousFlowThermalConductivityIdeal"
    l3 = f"    dry_thermal_conductivity = '3 0 0 0 3 0 0 0 3'"
    l4 = f"    block = ${{all_frac_ids}}"
    l5 = f"  []"
    file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n")

    file.write("[]\n")
