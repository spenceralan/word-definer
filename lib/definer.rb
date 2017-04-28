require "securerandom"

class Definition

  attr_accessor :describe

  def initialize(definition)
    self.describe = definition
  end

end

class Word
  attr_accessor :describe
  attr_accessor :definitions
  attr_accessor :id

  def initialize(word)
    self.describe = word
    self.definitions = Array.new
    self.id = SecureRandom.uuid
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

  @@dictionary = Array.new

  def self.save(word)
    @@dictionary.push(word)
  end

  def self.all_words
    @@dictionary
  end

  def self.empty
    @@dictionary = Array.new
  end
  
  def self.find_by_word(word_to_find)
    @@dictionary.select do |word|
      word_to_find == word.describe
    end
  end

  def self.find_by_id(id)
    @@dictionary.find do |word|
      id == word.id
    end
  end

  def self.delete_by_id(id)
    word = self.find_by_id(id)
    @@dictionary.delete(word)
  end

end
