# =============================================================================
# gene_expression_analysis.R
# =============================================================================
# Description : Basic gene expression data analysis and visualization.
#               Simulates a small RNA-seq-style dataset and performs:
#                 - Summary statistics per gene
#                 - Identification of highly expressed genes
#                 - Bar plot and boxplot visualizations
#
# Author      : [Your Name]
# Language    : R
# Libraries   : ggplot2 (install with: install.packages("ggplot2"))
# =============================================================================


# Load required library
# ggplot2 is the most popular R library for creating plots
library(ggplot2)


# =============================================================================
# STEP 1: Create a Simulated Gene Expression Dataset
# =============================================================================
# In real RNA-seq experiments, expression is measured in units like TPM or FPKM.
# Here we simulate counts for 10 genes across 6 samples (3 control, 3 treated).

set.seed(42)  # Set seed so results are reproducible

genes <- paste0("Gene_", LETTERS[1:10])  # Gene names: Gene_A to Gene_J

# Simulate expression counts (rounded to whole numbers, as in real count data)
expression_data <- data.frame(
  Gene      = genes,
  Control_1 = round(runif(10, min = 10, max = 500)),
  Control_2 = round(runif(10, min = 10, max = 500)),
  Control_3 = round(runif(10, min = 10, max = 500)),
  Treated_1 = round(runif(10, min = 50, max = 800)),
  Treated_2 = round(runif(10, min = 50, max = 800)),
  Treated_3 = round(runif(10, min = 50, max = 800))
)

cat("=== Raw Expression Data ===\n")
print(expression_data)


# =============================================================================
# STEP 2: Compute Summary Statistics
# =============================================================================
# Calculate the mean expression across all 6 samples for each gene

expression_data$Mean_Expression <- rowMeans(expression_data[, 2:7])

# Calculate standard deviation to understand variability
expression_data$SD_Expression <- apply(expression_data[, 2:7], 1, sd)

cat("\n=== Summary: Mean and SD per Gene ===\n")
print(expression_data[, c("Gene", "Mean_Expression", "SD_Expression")])


# =============================================================================
# STEP 3: Identify Highly Expressed Genes
# =============================================================================
# A simple threshold: genes with mean expression above 300 are "highly expressed"

threshold <- 300
high_expr_genes <- expression_data[expression_data$Mean_Expression > threshold, ]

cat(paste0("\n=== Highly Expressed Genes (Mean > ", threshold, ") ===\n"))
if (nrow(high_expr_genes) > 0) {
  print(high_expr_genes[, c("Gene", "Mean_Expression")])
} else {
  cat("No genes above the threshold.\n")
}


# =============================================================================
# STEP 4: Visualization 1 — Bar Plot of Mean Expression
# =============================================================================
# A bar chart showing mean expression per gene, sorted highest to lowest

# Sort genes by mean expression for a cleaner plot
expression_data$Gene <- factor(
  expression_data$Gene,
  levels = expression_data$Gene[order(expression_data$Mean_Expression, decreasing = TRUE)]
)

bar_plot <- ggplot(expression_data, aes(x = Gene, y = Mean_Expression, fill = Mean_Expression)) +
  geom_bar(stat = "identity") +
  # Add error bars using standard deviation
  geom_errorbar(
    aes(ymin = Mean_Expression - SD_Expression,
        ymax = Mean_Expression + SD_Expression),
    width = 0.3, color = "gray30"
  ) +
  # Use a color gradient: low expression = light blue, high = dark blue
  scale_fill_gradient(low = "#a8d8ea", high = "#1a5276") +
  # Add a dashed line at the "high expression" threshold
  geom_hline(yintercept = threshold, linetype = "dashed", color = "red", linewidth = 0.7) +
  annotate("text", x = 9.5, y = threshold + 20, label = "Threshold", color = "red", size = 3) +
  labs(
    title    = "Mean Gene Expression Across All Samples",
    subtitle = "Error bars show standard deviation | Dashed line = high-expression threshold",
    x        = "Gene",
    y        = "Mean Expression (counts)",
    fill     = "Mean Expr."
  ) +
  theme_minimal(base_size = 13) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot as a PNG file
ggsave("mean_expression_barplot.png", plot = bar_plot, width = 9, height = 5, dpi = 150)
cat("\nBar plot saved as: mean_expression_barplot.png\n")


# =============================================================================
# STEP 5: Visualization 2 — Boxplot: Control vs Treated
# =============================================================================
# Reshape data from "wide" format to "long" format for ggplot
# Wide: one row per gene, one column per sample
# Long: one row per (gene, sample) combination

long_data <- reshape(
  expression_data[, 1:7],       # Use only gene name + sample columns
  varying   = names(expression_data)[2:7],
  v.names   = "Expression",
  timevar   = "Sample",
  times     = names(expression_data)[2:7],
  direction = "long"
)

# Label each sample as either "Control" or "Treated"
long_data$Group <- ifelse(
  grepl("Control", long_data$Sample), "Control", "Treated"
)

box_plot <- ggplot(long_data, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(alpha = 0.7, outlier.shape = 16, outlier.size = 2) +
  # Add individual data points over the boxplot for transparency
  geom_jitter(width = 0.15, alpha = 0.5, size = 1.5, color = "gray30") +
  scale_fill_manual(values = c("Control" = "#82b366", "Treated" = "#e07b54")) +
  labs(
    title    = "Gene Expression: Control vs Treated",
    subtitle = "Each point represents one gene-sample measurement",
    x        = "Experimental Group",
    y        = "Expression (counts)",
    fill     = "Group"
  ) +
  theme_minimal(base_size = 13)

ggsave("control_vs_treated_boxplot.png", plot = box_plot, width = 7, height = 5, dpi = 150)
cat("Boxplot saved as: control_vs_treated_boxplot.png\n")


cat("\n=== Analysis Complete ===\n")
