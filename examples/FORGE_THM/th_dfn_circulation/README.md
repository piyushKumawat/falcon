# Directories:
- aleta_dfn
  - contains csv file of dfns.
  - Contains file telling injection and production points and which fracture they intersect

- field_data
  - csv files for 30 days circulation data.
  - I use this for plotting against simulation data (see simulation_inputs/plot_results.py)

- meshes
  - most of these files are created from the write_txt_for_3D_fracture_mesher.py script.
  - This directory also has the moose input files for steps 3 & 4
  - The stl file is just for paraview to make sure my DFN's look like Aletas.

- simulation_inputs
  - most of these files are created from the rest of the python scripts in step 1.
  - The main input file is 2dFrac_10zone.i and includes all of the other input files.
  - ext_fluid_properties2.csv is an equation of state file Rob gave me that extends the pressure bounds.

- well_locations
  - contains xyz coordinates of the FORGE wells.
  - 16A is a production well.
  - 58 is a close observation well.
  - 16B production points are found by offsetting the 16A points by 100m in z, there is a column for this in the 16A csv file.



# How to setup a simulation to run from Aletas csv file

1. Run all of the python scripts in simulation_setup_scripts/:
  - write_txt_for_3D_fracture_mesher.py
  - dfn_well_intersections.py
  - write_diracs_input.py
  - write_constant_frac_materials_input.py or write_nl_frac_materials_input.py


2.  Running write_txt_for_3D_fracture_mesher.py will convert Aletas csv file into a txt file for Andy Wilkins gmsh python script.
  - The txt files are in the meshes directory.
  - How to run the gmsh python script (ask Andy for access to script):
  - ```python ~/projects/3D_fracture_mesher/fractures_2d.py Case_A_Fractures_Local_10m.txt```
  - In geometry/planarfracture.py on line 85 I changed the tolerance to 1e-2.
  - need to run with python gmsh conda environment
  - conda activate gmsh_env


3. Running write_txt_for_3D_fracture_mesher.py will create an input file msh_to_exodus_rm_duplicate.i that will convert
  - the gmsh mesh to an exodus mesh.  It will also remove duplicate sidesets and place every fracture into its own block.
  - The exodus files this creates are runnable.
  - ```~/projects/falcon/falcon-opt -i msh_to_exodus_rm_duplicate.i mesh_size=5 --mesh-only - Case_B_Fractures_Local_5m.e```


4. Mark injection and production volume elements where diracs are and place them into their own block.
  - I added these because it is too hard to exactly place a dirac source onto the 2D fracture element.
  - ```mpirun -np 4 ~/projects/falcon/falcon-opt -i markDiracPoints.i mesh_size=5```


