require_relative "sequence"
require_relative "aminoacids"

class Classification
	include Aminoacids
 
	attr_reader :analyzed_sequences, :reference_sequences, :weight_first_codon, :weight_second_codon, :weight_third_codon
	
	def initialize()
    @reference_sequences = [] 
    @analyzed_sequences = []
    @weight_first_codon = 0.3
    @weight_second_codon = 0.6
    @weight_third_codon = 0.1
  end

  def add_reference(id, new_reference)
    if @reference_sequences.empty?
      @reference_sequences << Sequence.new(id, new_reference)
    elsif @reference_sequences.first.reference_nucleotide.size  == new_reference.size
      @reference_sequences << Sequence.new(id, new_reference)
    else
      p "The sequences must have the same sizes. #{id} not save"
    end
  end

  def add_sequence(id, new_sequence)
  	if @reference_sequences.first.reference_nucleotide.size  == new_sequence.size
  		@analyzed_sequences << Sequence.new(id, new_sequence)
  	else
  		p "The sequences must have the same sizes.  #{id} not save"
  	end
  end

  def weight_codons(new_weight_first_codon, new_weight_second_codon, new_weight_third_codon)
    sum = new_weight_first_codon + new_weight_second_codon + new_weight_third_codon
    if sum = 1
      @weight_first_codon = new_weight_first_codon
      @weight_second_codon = new_weight_second_codon
      @weight_third_codon = new_weight_third_codon
      true
    else
      false
    end
    
  end

  def show_ranking
  	if @analyzed_sequences.any?
      File.open('results.txt', 'w') do |f2|  
        @reference_sequences.each do |reference|
          f2.puts "*******************************************************************************************"
          f2.puts "***********    results for reference:" 
          f2.puts "***********    #{reference.id}" 
          f2.puts "***********    #{reference.reference_nucleotide}" 
          f2.puts "***********    #{reference.reference_aminoacid}"
          f2.puts " " 
          results = coef_laplic(reference)
          results.each do |key, value|
            f2.puts "#{key} -----> #{value}"
          end
          f2.puts " "
          f2.puts "     END for #{reference.id}   " 
          f2.puts "*******************************************************************************************"
          f2.puts " "
        end   
      end
  	else
  		p "There are no sequences to compare with the reference"
  	end
  end


  private

  def coef_laplic(reference)
    p "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
    p "Analysis in relation to reference: #{reference.id} >> #{reference.reference_aminoacid}"
  	results = {}
  	@analyzed_sequences.each do |sequence| #loop for each sequence added in the comparison
  		results[sequence.id] = 0              
  		sequence_codon = 0
  		reference.reference_aminoacid.each_char do |aminoacid| #loop for each reference amino acid
  			analyzed_codon = sequence.reference_nucleotide[sequence_codon..sequence_codon + 2] #separates the codons from the current sequence
  			points_codon = analize_bases(aminoacid, analyzed_codon)
  			results[sequence.id] += (points_codon * reference.weight_aminoacid) #calculates the value of the hit
  			sequence_codon += 3
  		end
  	end
    p "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
   	results.sort {|a,b| a[1] <=> b[1]}.reverse
  end

  def analize_bases(aminoacid, analyzed_codon)
  	points_codon = 0
  	no_hit_base_1 = true, no_hit_base_2 = true, no_hit_base_3 = true #ensures that no points were counted for any nucleotides of the codon
  		p "Evaluation of the amino acid: #{aminoacid} in relation to the codon: #{analyzed_codon}"
  		p "@@@@@@@@ analyzed => codon >> scores"
			Aminoacids::DICTIONARY[aminoacid.to_sym].each do |codon| #captures and compares the reference codon with the sequence codon
				if (analyzed_codon[0] == codon[0]) && no_hit_base_1
					points_codon += @weight_first_codon
					no_hit_base_1 = false
				end
				p "@@@@@@@@      #{analyzed_codon[0]}    =>    #{codon[0]}   >>   #{points_codon}"
				if (analyzed_codon[1] == codon[1]) && no_hit_base_2
					points_codon += @weight_second_codon
					no_hit_base_2 = false
				end
				p "@@@@@@@@      #{analyzed_codon[1]}    =>    #{codon[1]}   >>   #{points_codon}"
				if (analyzed_codon[2] == codon[2]) && no_hit_base_3
					points_codon += @weight_third_codon
					no_hit_base_3 == false
				end
				p "@@@@@@@@      #{analyzed_codon[2]}    =>    #{codon[2]}   >>   #{points_codon}"
				p " "
				break if points_codon >= 1.0000000000000000000 # if it have already hit the three positions it is no longer necessary to compare
			end
  	points_codon
  end

end #end class
