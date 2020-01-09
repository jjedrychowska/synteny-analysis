class GenomeIndex
  def initialize(genome)
    @genome = genome
    reindex
  end

  def neighbours(name, count = 10)
    chromosome_number, gene_index = @index[name]
    if gene_index
      left_neighbours = ([0, gene_index - count].max)..(gene_index-1)
      right_neighbours = (gene_index+1)..(gene_index + count)

      chromosome = @genome[chromosome_number]
      chromosome.genes[left_neighbours] + chromosome.genes[right_neighbours]
    end
  end

  def find_gene(name)
    chromosome_number, gene_index = @index[name]
    if gene_index
      @genome[chromosome_number].genes[gene_index]
    end
  end

  private

  def reindex
    @index = {}
    @genome.each do |chromosome|
      chromosome.genes.each_with_index { |gene, i| @index[gene.name] = [chromosome.number, i] }
    end
  end
end
