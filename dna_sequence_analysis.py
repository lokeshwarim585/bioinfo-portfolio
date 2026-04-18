# =============================================================================
# dna_sequence_analysis.py
# =============================================================================
# Description : Basic DNA sequence analysis tool.
#               Takes a DNA sequence and computes:
#                 - Nucleotide counts and GC content
#                 - Reverse complement
#                 - Transcription to mRNA
#                 - Simple motif search
#
# Author      : [Your Name]
# Language    : Python 3
# Libraries   : None (standard library only)
# =============================================================================


# --- Helper Functions --------------------------------------------------------

def count_nucleotides(sequence):
    """Count each nucleotide (A, T, G, C) in a DNA sequence."""
    sequence = sequence.upper()
    counts = {
        "A": sequence.count("A"),
        "T": sequence.count("T"),
        "G": sequence.count("G"),
        "C": sequence.count("C"),
    }
    return counts


def gc_content(sequence):
    """Calculate GC content as a percentage.
    
    GC content is the proportion of G and C bases in a sequence.
    High GC content often indicates more thermally stable DNA.
    """
    sequence = sequence.upper()
    gc = sequence.count("G") + sequence.count("C")
    return round((gc / len(sequence)) * 100, 2)


def reverse_complement(sequence):
    """Return the reverse complement of a DNA sequence.
    
    In double-stranded DNA, each strand is the reverse complement
    of the other (A pairs with T, G pairs with C).
    """
    sequence = sequence.upper()
    complement_map = {"A": "T", "T": "A", "G": "C", "C": "G"}
    complement = [complement_map[base] for base in sequence]
    return "".join(reversed(complement))


def transcribe_to_mrna(sequence):
    """Transcribe a DNA sequence to messenger RNA (mRNA).
    
    During transcription, DNA is converted to RNA.
    The only change: every T (Thymine) becomes U (Uracil).
    """
    return sequence.upper().replace("T", "U")


def find_motif(sequence, motif):
    """Find all positions where a motif (short pattern) occurs.
    
    Positions are reported as 1-based (first base = position 1),
    which is the standard convention in biology.
    """
    sequence = sequence.upper()
    motif = motif.upper()
    positions = []
    start = 0
    while True:
        pos = sequence.find(motif, start)
        if pos == -1:
            break
        positions.append(pos + 1)  # Convert to 1-based index
        start = pos + 1
    return positions


# --- Main Program ------------------------------------------------------------

def analyze_sequence(sequence, motif=None):
    """Run all analyses on a given DNA sequence and print a report."""
    
    print("=" * 55)
    print("       DNA SEQUENCE ANALYSIS REPORT")
    print("=" * 55)
    
    print(f"\nInput Sequence  : {sequence.upper()}")
    print(f"Sequence Length : {len(sequence)} bp (base pairs)")

    # Nucleotide counts
    counts = count_nucleotides(sequence)
    print("\n--- Nucleotide Composition ---")
    for base, count in counts.items():
        print(f"  {base}: {count}")

    # GC content
    print(f"\n--- GC Content ---")
    print(f"  {gc_content(sequence)}%")
    print("  (Normal range in many organisms: 40–60%)")

    # Reverse complement
    print(f"\n--- Reverse Complement ---")
    print(f"  5'-{reverse_complement(sequence)}-3'")

    # Transcription
    print(f"\n--- mRNA Transcript ---")
    print(f"  5'-{transcribe_to_mrna(sequence)}-3'")

    # Motif search
    if motif:
        positions = find_motif(sequence, motif)
        print(f"\n--- Motif Search: '{motif.upper()}' ---")
        if positions:
            print(f"  Found at position(s): {positions}")
        else:
            print(f"  Motif not found in sequence.")

    print("\n" + "=" * 55)


# --- Run Example -------------------------------------------------------------

if __name__ == "__main__":
    # Example sequence — replace with any DNA sequence you like
    sample_sequence = "ATGCGTACGATCGATCGATCGGCTAGCTAGCTACGATCGATCG"
    search_motif = "ATCG"

    analyze_sequence(sample_sequence, motif=search_motif)
