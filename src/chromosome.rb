require_relative './gene'

class Chromosome
  attr_reader :number, :genes, :genome

  def initialize(number, genome)
    @number = number
    @genes = []
    @genome = genome
  end

  def add(gene_name, forward)
    @genes << Gene.new(gene_name, forward, self)
  end
end
