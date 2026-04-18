# 🧬 Bioinformatics Portfolio

A small collection of beginner bioinformatics scripts written in Python and R.
These scripts demonstrate foundational concepts commonly used in biological data analysis.

---

## 📁 Repository Structure

```
bioinformatics-portfolio/
│
├── dna_sequence_analysis.py       # Python: DNA sequence analysis tool
├── gene_expression_analysis.R     # R: Gene expression visualization
└── README.md
```

---

## 🐍 Script 1 — DNA Sequence Analysis (Python)

**File:** `dna_sequence_analysis.py`  
**Language:** Python 3 | No external libraries required

### What it does
Takes any DNA sequence and computes:
- **Nucleotide counts** — frequency of A, T, G, C
- **GC content (%)** — indicator of thermal stability
- **Reverse complement** — the complementary antiparallel strand
- **mRNA transcript** — DNA → RNA transcription
- **Motif search** — finds all positions of a short pattern

### How to run
```bash
python dna_sequence_analysis.py
```

You can edit the `sample_sequence` and `search_motif` variables at the bottom of the script to test your own sequences.

### Example output
```
=======================================================
       DNA SEQUENCE ANALYSIS REPORT
=======================================================

Input Sequence  : ATGCGTACGATCGATCGATCGGCTAGCTAGCTACGATCGATCG
Sequence Length : 43 bp (base pairs)

--- Nucleotide Composition ---
  A: 8   T: 8   G: 14   C: 13

--- GC Content ---
  62.79%

--- Reverse Complement ---
  5'-CGATCGATCGTAGCTAGCTAGCCGATCGATCGATCGTACGCAT-3'

--- mRNA Transcript ---
  5'-AUGCGUACGAUCGAUCGAUCGGCUAGCUAGCUACGAUCGAUCG-3'

--- Motif Search: 'ATCG' ---
  Found at position(s): [10, 14, 18, 38, 42]
```

---

## 📊 Script 2 — Gene Expression Analysis (R)

**File:** `gene_expression_analysis.R`  
**Language:** R | Requires: `ggplot2`

### What it does
Simulates a small RNA-seq-style gene expression dataset (10 genes × 6 samples) and performs:
- **Summary statistics** — mean and standard deviation per gene
- **High-expression filtering** — flags genes above a defined threshold
- **Bar plot** — mean expression per gene with error bars
- **Boxplot** — Control vs Treated group comparison with data points

### How to run
Install the required package (first time only):
```r
install.packages("ggplot2")
```
Then run the script:
```bash
Rscript gene_expression_analysis.R
```

Two plots will be saved in the same directory:
- `mean_expression_barplot.png`
- `control_vs_treated_boxplot.png`

---

## 🧠 Concepts Covered

| Concept | Script |
|---|---|
| Nucleotide composition & GC content | Python |
| Reverse complement & transcription | Python |
| Motif/pattern search | Python |
| Simulating expression count data | R |
| Summary statistics (mean, SD) | R |
| Data reshaping (wide → long format) | R |
| ggplot2 visualization | R |

---

## 🚀 Getting Started

**Requirements:**
- Python 3.x
- R 4.x + `ggplot2` package

Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/bioinformatics-portfolio.git
cd bioinformatics-portfolio
```

---

## 👤 Author

LOkeshwari M — 
lokeshwarim585@gmail.com
---

*This is a learning portfolio. Scripts are intentionally well-commented for readability.*
