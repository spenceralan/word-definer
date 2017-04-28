class Definition

  attr_accessor :describe

  def initialize(definition)
    self.describe = definition
  end

end

class Word
  attr_accessor :describe
  attr_accessor :definitions

  def initialize(word)
    self.describe = word
    self.definitions = Array.new
  end

  def add_definition(definition)
    #expecting a definition object. throw error if anything else.
    self.definitions.push(definition)
  end

  def definition
    definitions.map do |definition|
      definition.describe
    end.join(" | ")
  end

end

module Dictionary

end
