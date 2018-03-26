require_relative "sequence"
require_relative "aminoacids"

class Classification
	include Aminoacids
 
	attr_reader :analyzed_sequences, :reference_sequences, :weight_first_codon, :weight_secound_codon, :weight_third_codon
	
	def initialize()
    @reference_sequences = [] 
    @analyzed_sequences = []
    @weight_first_codon = 0.3
    @weight_secound_codon = 0.6
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

  def weight_codons(new_weight_first_codon, new_weight_secound_codon, new_weight_third_codon)
    sum = new_weight_first_codon + new_weight_secound_codon + new_weight_third_codon
    if sum = 1
      @weight_first_codon = new_weight_first_codon
      @weight_secound_codon = new_weight_secound_codon
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
          f2.puts "***********    resultados para referencia:" 
          f2.puts "***********    #{reference.id}" 
          f2.puts "***********    #{reference.reference_nucleotide}" 
          f2.puts "***********    #{reference.reference_aminoacid}"
          f2.puts " " 
          results = coef_laplic(reference)
          results.each do |key, value|
            f2.puts "#{key} -----> #{(value * 100).round(1)}%"
          end
          f2.puts " "
          f2.puts "     FIM para #{reference.id}   " 
          f2.puts "*******************************************************************************************"
          f2.puts " "
        end   
      end
  	else
  		p "Não existem sequencias para comparar com a referencia"
  	end
  end


  private

  def coef_laplic(reference)
    p "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
    p "Analise  em relacao a referencia: #{reference.id} >> #{reference.reference_aminoacid}"
  	results = {}
  	@analyzed_sequences.each do |sequence| #loop para cada sequencia adicionada na comparação
  		results[sequence.id] = 0              
  		sequence_codon = 0
  		reference.reference_aminoacid.each_char do |aminoacid| #loop para cada aminoacido da referencia
  			analyzed_codon = sequence.reference_nucleotide[sequence_codon..sequence_codon + 2] #separa os codons da sequencia autal
  			points_codon = analize_bases(aminoacid, analyzed_codon)
  			results[sequence.id] += (points_codon * reference.weight_aminoacid) #calcula o valor do acerto
  			sequence_codon += 3
  		end
  	end
    p "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
   	results.sort {|a,b| a[1] <=> b[1]}.reverse
  end

  def analize_bases(aminoacid, analyzed_codon)
  	points_codon = 0
  	no_hit_base_1 = true, no_hit_base_2 = true, no_hit_base_3 = true #garante que não foi contado pontos para nenhuma base
  		p "Avaliacaoo do aminoacido: #{aminoacid} em relação ao codon: #{analyzed_codon}"
  		p "@@@@@@@@ analizado => trinca >> pontos"
			Aminoacids::DICTIONARY[aminoacid.to_sym].each do |trinca| #captura e compara as trincas da referencia com o codon da sequencia
				if (analyzed_codon[0] == trinca[0]) && no_hit_base_1
					points_codon += @weight_first_codon
					no_hit_base_1 = false
				end
				p "@@@@@@@@      #{analyzed_codon[0]}    =>    #{trinca[0]}   >>   #{points_codon}"
				if (analyzed_codon[1] == trinca[1]) && no_hit_base_2
					points_codon += @weight_secound_codon
					no_hit_base_2 = false
				end
				p "@@@@@@@@      #{analyzed_codon[1]}    =>    #{trinca[1]}   >>   #{points_codon}"
				if (analyzed_codon[2] == trinca[2]) && no_hit_base_3
					points_codon += @weight_third_codon
					no_hit_base_3 == false
				end
				p "@@@@@@@@      #{analyzed_codon[2]}    =>    #{trinca[2]}   >>   #{points_codon}"
				p " "
				break if points_codon >= 1.0000000000000000000 # se já acertou as três posições não é mais necessário comparar
			end
  	points_codon
  end

end #end class
