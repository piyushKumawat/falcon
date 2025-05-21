import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV file
df_9hr = pd.read_csv("thm_9hr_out.csv")
df_9hr_exp = pd.read_csv("16B_9hr_experimental_output.csv")
# Read the CSV file
df_year = pd.read_csv("thm_1yr_out.csv")
df_30day_exp = pd.read_csv("16B_30day_experimental_output.csv")
# Plot time vs surface_out_temp
plt.figure()
plt.plot(
    df_9hr_exp["time"] / 3600 + 1.1,
    df_9hr_exp["t_out_C"],
    linestyle="--",
    linewidth=2,
    color="black",
    label="Field Measured",
)
plt.plot(
    df_9hr["time"] / 3600,
    df_9hr["surface_out_temp"] - 273,
    linestyle="-",
    linewidth=2,
    color="red",
    label="Modeled",
)
plt.ylim(bottom=0)  # Sets the minimum y-axis limit to zero
plt.xlabel("Time (hours)")
plt.ylabel("Surface Out Temperature (C)")
plt.grid(True)
plt.legend()  # Adds the legend to the plot


plt.figure()
plt.plot(
    df_9hr_exp["time"] / 3600 + 1.1,
    df_9hr_exp["m_out_kg_s"],
    linestyle="--",
    linewidth=2,
    color="black",
    label="Field Measured",
)
plt.plot(
    df_9hr["time"] / 3600,
    df_9hr["m_dot_out_1"],
    linestyle="-",
    linewidth=2,
    color="red",
    label="Modeled",
)
plt.ylim(bottom=-1)  # Sets the minimum y-axis limit to zero
plt.xlabel("Time (hours)")
plt.ylabel("Mass Production (kg/s)")
plt.grid(True)
plt.legend()  # Adds the legend to the plot


# 1 year results

plt.figure()
plt.plot(
    df_year["time"] / 3600 / 24,
    df_year["surface_out_temp"] - 273,
    linestyle="-",
    linewidth=2,
    color="red",
    label="Modeled",
)
plt.ylim(bottom=0)  # Sets the minimum y-axis limit to zero
plt.xlabel("Time (days)")
plt.ylabel("Surface Out Temperature (C)")
plt.grid(True)
plt.legend()  # Adds the legend to the plot


plt.figure()
plt.plot(
    df_year["time"] / 3600 / 24,
    df_year["m_dot_out_1"],
    linestyle="-",
    linewidth=2,
    color="red",
    label="Modeled",
)
plt.ylim(bottom=-1)  # Sets the minimum y-axis limit to zero
plt.xlabel("Time (days)")
plt.ylabel("Mass Production (kg/s)")
plt.grid(True)
plt.legend()  # Adds the legend to the plot


plt.figure()
plt.plot(
    df_30day_exp["time"] / 3600 / 24 - 0.8,
    df_30day_exp["t_out_C"],
    linestyle="--",
    linewidth=2,
    color="black",
    label="Field Measured",
)
plt.plot(
    df_year["time"] / 3600 / 24,
    df_year["surface_out_temp"] - 273,
    linestyle="-",
    linewidth=2,
    color="red",
    label="Modeled",
)
plt.ylim(bottom=0)  # Sets the minimum y-axis limit to zero
plt.xlim(left=-1)
plt.xlim(right=30)
plt.xlabel("Time (days)")
plt.ylabel("Surface Out Temperature (C)")
plt.grid(True)
plt.legend()  # Adds the legend to the plot


plt.figure()
plt.plot(
    df_30day_exp["time"] / 3600 / 24 - 0.8,
    df_30day_exp["m_out_kg_s"],
    linestyle="--",
    linewidth=2,
    color="black",
    label="Field Measured",
)
plt.plot(
    df_year["time"] / 3600 / 24,
    df_year["m_dot_out_1"],
    linestyle="-",
    linewidth=2,
    color="red",
    label="Modeled",
)
plt.ylim(bottom=-1)  # Sets the minimum y-axis limit to zero
plt.xlim(left=-1)
plt.xlim(right=30)
plt.xlabel("Time (days)")
plt.ylabel("Mass Production (kg/s)")
plt.grid(True)
plt.legend()  # Adds the legend to the plot


plt.show()
