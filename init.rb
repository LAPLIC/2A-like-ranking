require_relative "classifier"

p " "
p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
p "$$$$$$$$$$   Welcome to 2A-like ranking, a software developed by LAPLIC! $$$$$$$$$"
p "$$$$$$$$$$                                                               $$$$$$$$$"
p "$$$$$$$$$$    This tool will help you to compare amino acid sequences    $$$$$$$$$"
p "$$$$$$$$$$    and to predict which one is closer to the reference.       $$$$$$$$$"
p "$$$$$$$$$$    The comparisons are ranked from 0 (zero) to 1 (one),       $$$$$$$$$"
p "$$$$$$$$$$    where 0 (zero) corresponds to totally different sequences  $$$$$$$$$"
p "$$$$$$$$$$    and 1 (one) to identical sequences.                        $$$$$$$$$"
p "$$$$$$$$$$    For more details, go to: https://github.com/LAPLIC         $$$$$$$$$"
p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
p " "

c = Classification.new()
dupla = []

p "-----   Do you want to read the references.txt file to import reference sequences automatically?  ---------"
p "1 - Yes"
p "2 - No"
p " "
option = gets
if option.chomp.to_i == 1
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	p "$$$$$$$$ Reading references from references.xlsx $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	IO.readlines('references.txt').each_with_index.map do |line|
	  unless line.chomp.empty?
			dupla << line.chomp
			if dupla.size == 2
				c.add_reference(dupla[0], dupla[1]) 
				dupla.clear
			end
	  end
	end
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	p "$$$$$$$$                                  $$$$$"
	p "$$$$$$$$         Reference list           $$$$$"
	p "$$$$$$$$                                  $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	c.reference_sequences.each do |reference|
		p reference.id
		p "#{reference.reference_nucleotide} >> #{reference.reference_aminoacid}"
		p ""
	end
end

p "-----   Do you want to read sequences.txt file to import sequences automatically?  ---------"
p "1 - Yes"
p "2 - No"
p " "
option = gets
if option.chomp.to_i == 1
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	p "$$$$$$$$ Reading references from references.xlsx $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	IO.readlines('sequences.txt').each_with_index.map do |line|
	  unless line.chomp.empty?
			dupla << line.chomp
			if dupla.size == 2
				c.add_sequence(dupla[0], dupla[1]) 
				dupla.clear
			end
	  end
	end
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	p "$$$$$$$$                                  $$$$$"
	p "$$$$$$$$          Sequence list           $$$$$"
	p "$$$$$$$$                                  $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	c.analyzed_sequences.each do |reference|
		p reference.id
		p "#{reference.reference_nucleotide} >> #{reference.reference_aminoacid}"
		p ""
	end
end


while true
	p "$$$$$$$$$  Press ENTER to view options $$$$$$$$$$$"
  seq = gets
	p "$$$$$$$$$$$$$ Options $$$$$$$$$$$$$$"
	p " "
	p "0 - Add REFERENCE to #{c.reference_sequences.size} already existing"
	p "1 - View references "
	p "2 - Add SEQUENCCE to #{c.analyzed_sequences.size} already existing"
	p "3 - View sequences already added"
	p "4 - View codon weights"
	p "5 - Change codon weights"
	p "6 - View ranking"
	p "7 - Exit"

	option = gets
	if option.chomp.to_i == 1
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 1 - View references $$$$$$$$$$$$$$"
		p " "
		c.reference_sequences.each do |r|
			p r.id
			p r.reference_nucleotide
			p r.reference_aminoacid
			p ""
		end
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 0
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 0 - Add REFERENCE $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$ Enter ID of the new REFERENCE $$$$$$$$$$$$$$$"
		id = gets
		p "$$$$$$$$$$$$$ Enter new REFERENCE $$$$$$$$$$$$$$$"
		seq = gets
		c.add_reference(id.chomp, seq.chomp)
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 2
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 2 - Add SEQUENCE $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$ Enter ID of the new SEQUENCE $$$$$$$$$$$$$$$"
		id = gets
		p "$$$$$$$$$$$$$ Enter new SEQUENCE $$$$$$$$$$$$$$$"
		seq = gets
		c.add_sequence(id.chomp, seq.chomp)
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 3
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 3 - View sequences already added $$$$$$$$$$$$$$$$$"
		p " "
		c.analyzed_sequences.each do |r|
			p r.id
			p r.reference_nucleotide
			p r.reference_aminoacid
			p ""
		end
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 4
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 4 - View codon weights $$$$$$$$$$$$$$$$$"
		p " "
		p "First codon => #{c.weight_first_codon}"
		p "Second codon  => #{c.weight_secound_codon}"
		p "Third codon => #{c.weight_third_codon}"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 5
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 5 - Change codon weights $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p "$$$$$$$$$$      Enter values separated by commas      $$$$$$$$$"
		p "$$$$$$$$$$      The sum must always be equal to 1     $$$$$$$$$"
		p "$$$$$$$$$$      Ex: 0.3,0.6,0.1,                       $$$$$$$$$"
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p " "
		weight = gets
		if c.weight_codons(weight.split(",")[0].to_f, weight.split(",")[1].to_f, weight.split(",")[2].to_f)
			p "Codon weights successfully modified"
		else
			p "Change in codon weights failed"
		end
	elsif option.chomp.to_i == 6
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 6 - View ranking $$$$$$$$$$$$$$$$$"
		p " "
		c.show_ranking
		p " "
		p "$$$$$$$$$$$$   See results.txt file    $$$$$$$$$$$$$$$$"
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 7
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Option 7 - Exit $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p "$$$$$$$$$$    Thank you for using our software           $$$$$$$$$"
		p "$$$$$$$$$$    Go to www.laplic.com.br for more options   $$$$$$$$$"
		p "$$$$$$$$$$    and bioinformatic tools.                   $$$$$$$$$"
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p " "
		break
	else
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$      Invalid Option     $$$$$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	end
	
end






