require_relative "aminoacids"

class Sequence
	include Aminoacids
	attr_reader :reference_nucleotide, :reference_aminoacid, :id, :weight_aminoacid

	def initialize(id, reference_sequence)
		@id = id.gsub(/^[>]/, '')
		@reference_nucleotide = reference_sequence.upcase.gsub(/\s+/, "").gsub(/[U]/, 'T')
		@reference_aminoacid = to_aminoacid(@reference_nucleotide)
    @weight_aminoacid = 1/@reference_aminoacid.size.to_f # assigns the numerical weight of each amino acid EX: "WQNK" 1/4 = 0.25 each 
	end
end
