require_relative './chromosome'
require_relative './genome_index'
require 'forwardable'

class Genome
  extend Forwardable
  include Enumerable
  def_delegators :chromosomes, :each
  def_delegators :index, :neighbours, :find_gene
  attr_reader :name

  def initialize(name)
    @name = name
    @chromosomes = {}
  end

  def chromosomes
    @chromosomes.values
  end

  def [](number)
    @chromosomes[number] ||= Chromosome.new(number, self)
  end

  def duplicated_genes
    chromosomes.flat_map do |chromosome|
      chromosome.genes.find_all(&:potential_duplicate?)
    end
  end

  private

  def index
    @index ||= GenomeIndex.new(self)
  end
end
