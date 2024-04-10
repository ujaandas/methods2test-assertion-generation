import os
import pandas as pd
import matplotlib.pyplot as plt

# Debugging dir
cwd = os.getcwd()  # Get the current working directory (cwd)
files = os.listdir(cwd)  # Get all the files in that directory
print("Files in %r: %s" % (cwd, files))

# Get list of all txt files in the output directory
file_list = [f for f in os.listdir(f"{cwd}/output") if f.endswith('.txt')]

# Initialize an empty DataFrame
df = pd.DataFrame()

# Read each file and append the data to the DataFrame
for file in file_list:
    data = pd.read_csv(os.path.join(f"{cwd}/output", file), sep='\s+')
    df = df._append(data, ignore_index=True)

# Sum the counts of each assertion type
sums = df.drop(columns='Line').sum()

# Plot the total counts as a bar chart
ax = sums.plot(kind='bar', figsize=(10, 6))
plt.title('Total Counts of Each Assertion Type')
plt.xlabel('Assertion Type')
plt.ylabel('Count')

# Add the exact counts above each bar
for i in range(len(sums)):
    ax.text(i, sums[i] + 0.5, sums[i], ha='center')

plt.show()
