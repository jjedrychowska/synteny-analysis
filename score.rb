#!/usr/bin/env ruby

require_relative "src/load_csv_genes"

human_genes = LoadCSVGenes.call "csv/homo_sapiens_core_98_38.csv", "Human"
danio_genes = LoadCSVGenes.call "csv/danio_rerio_core_98_11.csv", "Zebrafish"
spotted_genes = LoadCSVGenes.call "csv/lepisosteus_oculatus_core_98_1.csv", "Spotted gar"

checked_genes = [danio_genes, spotted_genes]

groupped_duplicates = checked_genes.flat_map(&:duplicated_genes).group_by(&:original_name)

groupped_duplicates.each do |original_name, group|
  human_neighbors = human_genes.neighbours(original_name) || []

  human_gene = human_genes.find_gene original_name
  if human_gene
    puts "GENE: #{original_name} chr. #{human_gene.chromosome.number} #{human_gene.forward ? "(forward)" : "(reverse)"}"
  else
    puts "GENE: #{original_name}"
  end

  human_neighbors = human_neighbors.map(&:name)
  original_genes = checked_genes.map do |genome|
    genome.find_gene original_name
  end.compact

  (group + original_genes).uniq.each do |gene|
    genome = gene.chromosome.genome
    neighbors = genome.neighbours(gene.name)
    valid_neighbors = neighbors.find_all do |neighbour_gene|
      (neighbour_gene.possible_names & human_neighbors).any?
    end
    score = valid_neighbors.count
    print "Score for #{gene.to_s(:full)}: #{score}"
    print ", common: #{valid_neighbors.map(&:to_s).join(", ")}" if score != 0
    print "\n"
  end
  puts
end

