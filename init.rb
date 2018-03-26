require_relative "classificador"

p " "
p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
p "$$$$$$$$$$    Bem vindo ao classificador de evolucao do LAPLIC          $$$$$$$$$"
p "$$$$$$$$$$    Essa ferramenta atribui um coeficiente da possibilidade   $$$$$$$$$"
p "$$$$$$$$$$    de uma determinada sequencia evoluir para outra,          $$$$$$$$$"
p "$$$$$$$$$$    atribuindo valores de 0 (zero) a 1 (um) entre as          $$$$$$$$$"
p "$$$$$$$$$$    comparacoes, onde zero (0) nada possiveis e um (1) para   $$$$$$$$$"
p "$$$$$$$$$$    Sequencias totalmente possiveis, para mais detalhes       $$$$$$$$$"
p "$$$$$$$$$$    do algoritimo acesse https://github.com/LAPLIC            $$$$$$$$$"
p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
p " "

c = Classification.new()
dupla = []

p "-----   Deseja ler o arquivo references.txt para importa sequencias de referenica automaticamente?  ---------"
p "1 - Sim"
p "2 - Nao"
p " "
option = gets
if option.chomp.to_i == 1
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	p "$$$$$$$$ Lendo as referencias no arquivo  $$$$$"
	p "$$$$$$$$   references.xlsx na mesma pasta $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
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
	p "$$$$$$$$   Lista de referencias           $$$$$"
	p "$$$$$$$$                                  $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	c.reference_sequences.each do |reference|
		p reference.id
		p "#{reference.reference_nucleotide} >> #{reference.reference_aminoacid}"
		p ""
	end
end

p "-----   Deseja ler o arquivo sequences.txt para importa sequencias automaticamente?  ---------"
p "1 - Sim"
p "2 - Nao"
p " "
option = gets
if option.chomp.to_i == 1
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	p "$$$$$$$$ Lendo as Sequencias no arquivo  $$$$$"
	p "$$$$$$$$   sequences.xlsx na mesma pasta $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
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
	p "$$$$$$$$   Lista de Sequencias            $$$$$"
	p "$$$$$$$$                                  $$$$$"
	p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	c.analyzed_sequences.each do |reference|
		p reference.id
		p "#{reference.reference_nucleotide} >> #{reference.reference_aminoacid}"
		p ""
	end
end


while true
	p "$$$$$$$$$  pressione ENTER para ver opcoes $$$$$$$$$$$"
  seq = gets
	p "$$$$$$$$$$$$$ Opcoes $$$$$$$$$$$$$$"
	p " "
	p "0 - Adicionar REFERENCIA as #{c.reference_sequences.size} ja existentes"
	p "1 - Exibir referencias "
	p "2 - Adicionar SEQUENCIA as #{c.analyzed_sequences.size} ja existentes"
	p "3 - Exibir sequencias ja Adicionadas"
	p "4 - Exibir pesos dos codons"
	p "5 - Alterar os pesos dos codons"
	p "6 - Exibir ranking"
	p "7 - Sair "

	option = gets
	if option.chomp.to_i == 1
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Opcao 1 - Exibir referencias $$$$$$$$$$$$$$"
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
		p "$$$$$$$$$$$$$ Opcao 0 - Adicionar REFERENCIA $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$ Digite ID da nova REFERENCIA $$$$$$$$$$$$$$$"
		id = gets
		p "$$$$$$$$$$$$$ Digite nova REFERENCIA $$$$$$$$$$$$$$$"
		seq = gets
		c.add_reference(id.chomp, seq.chomp)
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 2
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Opcao 2 - Adicionar SEQUENCIA $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$ Digite ID nova SEQUENCIA $$$$$$$$$$$$$$$"
		id = gets
		p "$$$$$$$$$$$$$ Digite nova SEQUENCIA $$$$$$$$$$$$$$$"
		seq = gets
		c.add_sequence(id.chomp, seq.chomp)
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 3
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Opcao 3 - Exibir sequencias ja Adicionadas $$$$$$$$$$$$$$$$$"
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
		p "$$$$$$$$$$$$$ Opcao 4 - Exibir pesos dos codons $$$$$$$$$$$$$$$$$"
		p " "
		p "Primeiro codon => #{c.weight_first_codon}"
		p "Segundo codon  => #{c.weight_secound_codon}"
		p "Terceiro codon => #{c.weight_third_codon}"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 5
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Opcao 5 - Alterar os pesos dos codons $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p "$$$$$$$$$$    Digite valores separados por virgula       $$$$$$$$$"
		p "$$$$$$$$$$    Somatorio deve ser sempre igual a 1        $$$$$$$$$"
		p "$$$$$$$$$$    Ex: 0.3,0.6,0.1                            $$$$$$$$$"
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p " "
		weight = gets
		if c.weight_codons(weight.split(",")[0], weight.split(",")[1], weight.split(",")[2])
			p "Pesos modificados com sucesso"
		else
			p "Nao foi possivel realizar a mudanca"
		end
	elsif option.chomp.to_i == 6
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Opcao 6 - Exibir ranking $$$$$$$$$$$$$$$$$"
		p " "
		c.show_ranking
		p " "
		p "$$$$$$$$$$$$   Consulte o arquivo results.txt     $$$$$$$$$$$$$$$$"
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	elsif option.chomp.to_i == 7
		Gem.win_platform? ? (system "cls") : (system "clear")
		p " "
		p "$$$$$$$$$$$$$ Opcao 7 - Sair $$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p "$$$$$$$$$$    Obrigado por utiizar nossa ferramenta      $$$$$$$$$"
		p "$$$$$$$$$$    acesse www.laplic.com.br para mais opcoes  $$$$$$$$$"
		p "$$$$$$$$$$    e ferramentas de bioinformatica            $$$$$$$$$"
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p " "
		break
	else
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$      Opcao invalida     $$$$$$$$$$$$$$$$$$$$"
		p " "
		p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
	end
	
end






