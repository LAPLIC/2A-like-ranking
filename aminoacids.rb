module Aminoacids
	DICTIONARY = { "F": ["TTT" , "TTC"],
								 "L": ["TTA" , "TTG" , "CTT" , "CTC" , "CTA", "CTG"],
								 "I": ["ATT" , "ATC" , "ATA"],
								 "M": ["ATG"],
								 "V": ["GTT" , "GTC" , "GTA" , "GTG"],
								 "S": ["TCT" , "TCC" , "TCA" , "TCG" , "AGT" , "AGC"],
								 "P": ["CCT" , "CCC" , "CCA" , "CCG"],
								 "T": ["ACT" , "ACC" , "ACA" , "ACG"],
								 "A": ["GCT" , "GCC" , "GCA" , "GCG"],
								 "Y": ["TAT" , "TAC"],
								 "H": ["CAT" , "CAC"],
								 "Q": ["CAA" , "CAG"],
								 "N": ["AAT" , "AAC"],
								 "K": ["AAA" , "AAG"],
								 "D": ["GAT" , "GAC"],
								 "E": ["GAA" , "GAG"],
								 "C": ["TGT" , "TGC"],
								 "W": ["TGG"],
								 "R": ["CGT" , "CGC" , "CGA" , "CGG" , "AGA" , "AGG"],
								 "G": ["GGT" , "GGC" , "GGA" , "GGG"],
								 "STOP": ["TAA" , "TAG" , "TGA"] }

	def to_aminoacid(sequence)
    frame = ""
    codon = 0
    while codon < sequence.size do
      aminoacid = make_aminoacid(sequence[codon..codon + 2])
      break if aminoacid == "STOP"
      frame += aminoacid unless aminoacid.nil?
      codon += 3
    end
    frame
  end

	private
	def make_aminoacid(peptide)
		aminoacid = nil
		DICTIONARY.each do |key,values|
			if values.include?(peptide)
				aminoacid = key.to_s
				break
			end
		end
		aminoacid
  end

end