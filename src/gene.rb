class Gene
  attr_reader :name, :chromosome, :forward

  def initialize(name, forward, chromosome)
    @name = name.downcase
    @chromosome = chromosome
    @forward = forward
  end

  def alphabet_last_letter?
     name[-1].ord > 65
  end

  def original_name
    @original_name ||= name.gsub(/[a-z]+$/, '')
  end

  def potential_duplicate?
    alphabet_last_letter? && name =~ /\d[a-k,m-z]+$/
  end

  def possible_names
    names = [name]
    temp_name = name
    loop do
      temp_name = temp_name[0..-2]
      names << temp_name
      break if temp_name.size <= original_name.size
    end
    names
  end

  def to_s(format = :default)
    base = "#{name} #{forward ? "(forward)" : "(reverse)"}"
    if format == :full
      "#{base} chr. #{chromosome.number} (#{chromosome.genome.name})"
    else
      base
    end

  end

  def inspect
    to_s
  end
end
