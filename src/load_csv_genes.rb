require 'csv'
require_relative './genome'

class LoadCSVGenes
  class << self
    def call(path, name)
      genome = Genome.new name

      CSV.open(path, col_sep: ';', headers: true) do |csv|
        csv.each do |row|
          genome[row['chromosome'].to_i].add(
            row['name'], row['seq_region_strand'] == '1'
          )
        end
      end

      genome
    end
  end
end
