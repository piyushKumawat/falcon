import pandas as pd
import numpy as np
import csv

##############  FIRST RUN dfn_well_intersections.py
# ---- this file will write individual files for the pressure, temperature dirac kernels
# ---- and the pressure,temperature postprocessors at the inejction and production points.
# ---- 6 files will be created.


def format_number(value):
    if value % 1 == 0:
        return f"{int(value)}"
    else:
        formatted_value = f"{value:.1f}".replace(".", "_")
        return formatted_value


######################
#
# SET READ WRITE DIRECTORY
#
output_dir = "../simulation_inputs/"
#
######################


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
df = pd.read_csv(f"{output_dir}/injection_points.csv")
df_prod = pd.read_csv(f"{output_dir}/production_points.csv")


############ WRITE DIRAC KERNELS
with open(f"{output_dir}/injection_pressure_diracs.i", "w") as file:
    file.write("# created by write_diracs_input.py\n")
    file.write("[DiracKernels]\n")
    for index, row in df.iterrows():
        stage = row["stage"]
        stage = format_number(stage)
        x = row["x"]
        y = row["y"]
        z = row["z"]
        l1 = f"  [source_{stage}]"
        l2 = f"    type = PorousFlowPointSourceFromPostprocessor"
        l3 = f"    variable = porepressure"
        l4 = f"    mass_flux = mass_flux_src_stage_{stage}"
        l5 = f"    point = '{x:.{precision}f} {y:.{precision}f} {z:.{precision}f}'"
        l6 = f"    point_not_found_behavior = WARNING"
        l7 = f"    # block = 100"
        l100 = f"  []"
        file.write(
            l1
            + "\n"
            + l2
            + "\n"
            + l3
            + "\n"
            + l4
            + "\n"
            + l5
            + "\n"
            + l6
            + "\n"
            + l7
            + "\n"
            + l100
            + "\n"
        )
    file.write("[]\n")

with open(f"{output_dir}/injection_temperature_diracs.i", "w") as file:
    file.write("# created by write_diracs_input.py\n")
    file.write("[DiracKernels]\n")
    for index, row in df.iterrows():
        stage = row["stage"]
        stage = format_number(stage)
        x = row["x"]
        y = row["y"]
        z = row["z"]

        ll01 = f"  [source_{stage}_h]"
        ll02 = f"    type = PorousFlowPointEnthalpySourceFromPostprocessor"
        ll03 = f"    variable = temperature"
        ll04 = f"    mass_flux = mass_flux_src_stage_{stage}"
        ll05 = f"    point = '{x:.{precision}f} {y:.{precision}f} {z:.{precision}f}'"
        ll06 = f"    T_in = inject_T"
        ll07 = f"    pressure = porepressure"
        ll08 = f"    fp = tabulated_water"
        ll09 = f"    point_not_found_behavior = WARNING"
        ll10 = f"    # block = 100"
        ll20 = f"  []"
        file.write(
            ll01
            + "\n"
            + ll02
            + "\n"
            + ll03
            + "\n"
            + ll04
            + "\n"
            + ll05
            + "\n"
            + ll06
            + "\n"
            + ll07
            + "\n"
            + ll08
            + "\n"
            + ll09
            + "\n"
            + ll10
            + "\n"
            + ll20
            + "\n"
        )
    file.write("[]\n")

############ WRITE INJECTION POSTPROCESSORS
with open(f"{output_dir}/injection_pressure_pp.i", "w") as file:
    file.write("####### INJECTION PRESSURE POSTPROCESSORS\n")
    file.write("# created by write_diracs_input.py\n")
    file.write("[Postprocessors]\n")
    for index, row in df.iterrows():
        x = row["x"]
        y = row["y"]
        z = row["z"]
        stage = row["stage"]
        stage = format_number(stage)
        l1 = f"  [p_in_{stage}]"
        l2 = f"    type = PointValue"
        l3 = f"    variable = Pdiff"
        l4 = f"    point = '{x} {y} {z}'"
        l5 = f"  []"
        file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n")
    file.write("[]\n")

with open(f"{output_dir}/injection_temperature_pp.i", "w") as file:
    file.write("####### INJECTION TEMPERATURE POSTPROCESSORS\n")
    file.write("# created by write_diracs_input.py\n")
    file.write("[Postprocessors]\n")
    for index, row in df.iterrows():
        x = row["x"]
        y = row["y"]
        z = row["z"]
        stage = row["stage"]
        stage = format_number(stage)
        l1 = f"  [t_in_{stage}]"
        l2 = f"    type = PointValue"
        l3 = f"    variable = Tdiff"
        l4 = f"    point = '{x} {y} {z}'"
        l5 = f"  []"
        file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n")
    file.write("[]\n")

############ WRITE PRODUCTION POSTPROCESSORS
with open(f"{output_dir}/production_pressure_pp.i", "w") as file:
    file.write("####### PRODUCTION PRESSURE POSTPROCESSORS\n")
    file.write("# created by write_diracs_input.py\n")
    file.write("[Postprocessors]\n")
    for index, row in df_prod.iterrows():
        x = row["x"]
        y = row["y"]
        z = row["z"]
        l1 = f"  [p_out_z_{z:.{1}f}]"
        l2 = f"    type = PointValue"
        l3 = f"    variable = Pdiff"
        l4 = f"    point = '{x} {y} {z}'"
        l5 = f"  []"
        file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n")
    file.write("[]")

with open(f"{output_dir}/production_temperature_pp.i", "w") as file:
    file.write("####### PRODUCTION TEMPERATURE POSTPROCESSORS\n")
    file.write("# created by write_diracs_input.py\n")
    file.write("[Postprocessors]\n")
    for index, row in df_prod.iterrows():
        x = row["x"]
        y = row["y"]
        z = row["z"]
        l1 = f"  [t_out_z_{z:.{1}f}]"
        l2 = f"    type = PointValue"
        l3 = f"    variable = Tdiff"
        l4 = f"    point = '{x} {y} {z}'"
        l5 = f"  []"
        file.write(l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n")
    file.write("[]")

with open(f"{output_dir}/injection_rates.i", "w") as file:
    file.write("####### INJECTION RATES AND POSTPROCESSORS\n")
    file.write("# created by write_diracs_input.py\n\n")
    for index, row in df.iterrows():
        stage = row["stage"]
        stage = format_number(stage)
        ratio = row["ratio"]
        file.write(f"inj_ratio_stage_{stage} = {ratio}\n")
    file.write("\n")
    file.write("[Postprocessors]\n")
    for index, row in df.iterrows():
        stage = row["stage"]
        stage = format_number(stage)
        l1 = f"  [mass_flux_src_stage_{stage}]"
        l2 = f"    type = FunctionValuePostprocessor"
        l3 = f"    function = mass_flux_src"
        input_string = "{inj_ratio_stage_" + str(stage) + "}"
        l4 = f"    scale_factor = ${input_string}"
        l5 = f"    execute_on = 'initial timestep_end'"
        l6 = f"  []"
        file.write(
            l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5 + "\n" + l6 + "\n"
        )
    file.write("[]")
