import matplotlib.pyplot as plt
from matplotlib_venn import venn2, venn2_circles, venn3, venn3_circles

# Define the sizes of each category
sizes = [20, 15, 27, 15]

# Create the Venn diagram
venn2(subsets=(sizes[0], sizes[1], sizes[0] + sizes[1]), set_labels=('Category 1', 'Category 2'))
venn2(subsets=(sizes[0], sizes[2], sizes[0] + sizes[2]), set_labels=('Category 1', 'Category 3'), ax=plt.gca())
venn2(subsets=(sizes[1], sizes[2], sizes[1] + sizes[2]), set_labels=('Category 2', 'Category 3'), ax=plt.gca())
venn3(subsets=(sizes[0], sizes[1], sizes[2], sizes[0] + sizes[1] + sizes[2]), set_labels=('Category 1', 'Category 2', 'Category 3'))

# Calculate and display the percentages of overlapping areas
plt.text(0.45, 0.5, f"{sizes[0]} ({(sizes[0]/38*100):.1f}%)")
plt.text(0.15, 0.5, f"{sizes[1]} ({(sizes[1]/38*100):.1f}%)")
plt.text(0.28, 0.3, f"{sizes[2]} ({(sizes[2]/38*100):.1f}%)")
plt.text(0.42, 0.3, f"{sizes[3]} ({(sizes[3]/38*100):.1f}%)")

# Set colors for each category
venn2_circles(subsets=(sizes[0], sizes[1], sizes[0] + sizes[1]), linewidth=3)
venn2_circles(subsets=(sizes[0], sizes[2], sizes[0] + sizes[2]), linewidth=3, ax=plt.gca())
venn2_circles(subsets=(sizes[1], sizes[2], sizes[1] + sizes[2]), linewidth=3, ax=plt.gca())
venn3_circles(subsets=(sizes[0], sizes[1], sizes[2], sizes[0] + sizes[1] + sizes[2]), linewidth=3)

# Display the Venn diagram
plt.show()
