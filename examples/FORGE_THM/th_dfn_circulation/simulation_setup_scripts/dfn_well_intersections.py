import pandas as pd
import numpy as np
import csv

print(
    "\n********************************************\n"
    "Step 1: write_txt_for_3D_fracture_mesher.py\n"
    "Step 2: dfn_well_intersections.py  \n"
    "Step 3: write_diracs_input.py \n"
    "Step 4: write_nl_frac_materials_input.py or write_constant_frac_materials_input.py \n"
    "********************************************\n"
)
# Read the CSV file
output_dir = "../simulation_inputs/"
df = pd.read_csv(
    "../aleta_dfn/dfn_2025_03_14/27fracs.csv"
)

feetToMeters = 0.3048
# INJECTION LINE
# line Points
p0_in = np.array([419.0811444, 264.8516218, 203.5178066])  # Start point of the line
p1_in = np.array([-261.5292174, 191.4975143, 506.778114])  # end of line
pipe_vec = p0_in - p1_in
pipe_vec = pipe_vec / np.linalg.norm(pipe_vec)
# OVERWRITING the z-axis this is explicitly using the angle they gave instead of two points points ie p0_in and p1_in
pipe_vec[2] = -np.cos(np.deg2rad(65))
# PRODUCTION LINE
z_offset = np.array([0, 0, 100])  # find intersection with z +=100m:
p0_out = p0_in + z_offset

# Open the output file
injection_points = []
production_points = []
injection_points_names = []
production_points_names = []
# Iterate through each row and generate the sentences
for index, row in df.iterrows():
    fracture_name = row["Fracture ID"]
    center = [row["FractureX[m]"], row["FractureY[m]"], row["FractureZ[m]"]]
    radius = row["FractureRadius[m]"]
    trend_deg = row["Trend[deg]"]
    # FIXME  DON"T FORGET THIS THE +90!  Ask Aleta why
    plunge_deg = row["Plunge[deg]"] 
    strike_deg = row["Strike[deg]"]

    center = np.array(center)
    strike_radians = np.radians(strike_deg)
    dip_trend_radians = np.radians(trend_deg)
    dip_plunge_radians = np.radians(plunge_deg)
    strike1 = (np.sin(strike_radians), np.cos(strike_radians), 0)
    dip = (
        np.sin(dip_trend_radians) * np.cos(dip_plunge_radians),
        np.cos(dip_trend_radians) * np.cos(dip_plunge_radians),
        -np.sin(dip_plunge_radians),
    )

    normal = (
        strike1[1] * dip[2] - strike1[2] * dip[1],
        strike1[2] * dip[0] - strike1[0] * dip[2],
        strike1[0] * dip[1] - strike1[1] * dip[0],
    )
    normal = normal / np.linalg.norm(normal)

    # Ensure the direction vector and normal vector are normalized
    pipe_vec = pipe_vec / np.linalg.norm(pipe_vec)
    # Calculate the dot product of v and n
    dot_vn = np.dot(pipe_vec, normal)
    # Check if the line is parallel to the plane
    if abs(dot_vn) < 1e-6:
        # The line is parallel to the plane of the circle
        print(
            "*******The line does not intersect the circle, or the plane, THIS SHOULD NOT HAPPEN."
        )

    ##### INJECTION INTERSECTION
    # Calculate the parameter t for the intersection with the plane
    t = np.dot(normal, (center - p0_in)) / dot_vn
    # Calculate the intersection point with the plane
    P = p0_in + t * pipe_vec
    if np.linalg.norm(P - center) <= radius:
        injection_points.append(P)
        injection_points_names.append(fracture_name)

    ##### PRODUCTION INTERSECTION
    # Calculate the parameter t for the intersection with the plane
    t = np.dot(normal, (center - p0_out)) / dot_vn
    # Calculate the intersection point with the plane
    P = p0_out + t * pipe_vec
    if np.linalg.norm(P - center) <= radius:
        production_points.append(P)
        production_points_names.append(fracture_name)

# print injection production points and names
print("Injection points and names.")
for index, point in enumerate(injection_points):
    print(f"DFN id {injection_points_names[index]} at: {point}")
print("Production points and names.")
for index, point in enumerate(injection_points):
    print(f"DFN id {injection_points_names[index]} at: {point}")
# Set precision for output
precision = 10
injection_points = sorted(injection_points, key=lambda point: point[2])
production_points = sorted(production_points, key=lambda point: point[2], reverse=True)
#
#
with open(
    f"{output_dir}/all_injection_intersection_points.csv", mode="w", newline=""
) as file:
    writer = csv.writer(file)
    writer.writerow(["index", "x", "y", "z", "fractureID"])  # Header row
    # Loop through injection points and stages
    for index, point in enumerate(injection_points):
        # Format each coordinate to the specified precision
        formatted_point = [f"{coord:.{precision}f}" for coord in point]
        formatted_point = [index + 1] + formatted_point
        formatted_point.append(injection_points_names[index])
        # Write the formatted point to the CSV file
        writer.writerow(formatted_point)

with open(f"{output_dir}/production_points.csv", mode="w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(["index", "x", "y", "z"])  # Header row
    # Loop through injection points and stages
    for index, point in enumerate(production_points):
        # Format each coordinate to the specified precision
        formatted_point = [f"{coord:.{precision}f}" for coord in point]
        formatted_point = [index + 1] + formatted_point
        # Write the formatted point to the CSV file
        writer.writerow(formatted_point)
#
#

# uses injection dfn intersections from dfn case_A March 15, 2025
# These are the stages for the z coordiantes from:
# /Users/mundlb/projects/userSupport/falcon/bigRun/dfn_2025/aletaDFN/injection_production_pts.xlsx
# xl sheet inj_prod_pts
# This process is not automatic, you have to run the above part first, get all the injection dfn intersections
# Then postprocess in in the xl sheet to try matching the z-coordinate of the intersections up
# with the injection locations of the stages.
# These two arrays should be the same size and you get it from teh xl sheet
# Case_A all_injection_intersection_points indices
# stages = np.array([1, 2, 3, 4, 5, 8, 9.2, 9.4, 9.5, 9.6, 9.7, 9.8, 10])
# dfn_injection_index = np.array([0, 1, 2, 4, 6, 9, 10, 11, 12, 13, 14, 15, 16])
# injection_ratio = np.array([0.0848 ,0.01696 ,0.06784 ,0.0848 ,0.0848 ,0.1624 ,0.0494 ,0.044 ,0.124 ,0.091 ,0.032 ,0.0473 ,0.0924])
# Case_B all_injection_intersection_points indices
# These use Aletas intersections points.
# Injection rates come from Pengju Stanford 2025 paper For August 2024 circulation
stages = np.array(
    [1.0, 1.1, 1.4, 2.1, 3.1, 4.1, 6.2, 7.1, 8.2, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 10]
)
dfn_injection_index = np.array(
    [0, 1, 3, 4, 6, 9, 10, 12, 15, 17, 18, 19, 20, 21, 22, 25]
)
injection_ratio = np.array(
    [
        0.051,
        0.051,
        0.051,
        0.051,
        0.051,
        0.051,
        0,
        0,
        0.261,
        0.031,
        0.01,
        0.05,
        0.045,
        0.025,
        0.014,
        0.258,
    ]
)

if len(stages) != len(dfn_injection_index):
    raise ValueError(
        f"""stage and dfn_injection_index are not the same size.
        Need to fix: len(stages)= {len(stages)}
        len(dfn_injection_index)= {len(dfn_injection_index)}"""
    )
if len(stages) != len(injection_ratio):
    raise ValueError(
        f"""stage and injection_ratio are not the same size.
        Need to fix: len(stages)= {len(stages)}
        len(injection_ratio)= {len(injection_ratio)}"""
    )
injection_sum = np.sum(injection_ratio)
if not np.isclose(injection_sum, 1, atol=0.01):
    raise ValueError(f"injection_ratio should be one, ours is: {injection_sum}")

# Set precision for output
precision = 10
# Write intersection points to a CSV file
# Sort intersection points by the z coordinate
# filtering the production points based on the stages I want to keep
filtered_injection_points = [injection_points[i] for i in dfn_injection_index]
with open(f"{output_dir}/injection_points.csv", mode="w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(["x", "y", "z", "stage", "ratio"])  # Header row
    # Loop through injection points and stages
    for index, point in enumerate(filtered_injection_points):
        # Format each coordinate to the specified precision
        formatted_point = [f"{coord:.{precision}f}" for coord in point]
        formatted_point.append(stages[index])
        formatted_point.append(injection_ratio[index])
        # Write the formatted point to the CSV file
        writer.writerow(formatted_point)


# Write production points to file in PorousFlowPeacemanBorehole
# Keep all of the production points
# Sort production points by the z coordinate
# format no header, no commas, add weight and lowest point must be first in file
with open(f"{output_dir}/peaceman_production_points.txt", mode="w", newline="") as file:
    writer = csv.writer(file, delimiter=" ")
    for point in production_points:
        point_with_weight = np.append(0.1, point)
        formatted_point = [f"{coord:.{precision}f}" for coord in point_with_weight]
        writer.writerow(formatted_point)
