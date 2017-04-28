require "definer"
require "rspec"
require "pry"

describe "Word" do

  describe "#describe" do
    it "returns the word" do
      word = Word.new("apple")
      expect(word.describe).to eq "apple"
    end
  end

  describe "definition" do
    word = Word.new("apple")

    it "returns the definition" do
      definition1 = Definition.new("fruit")
      word.add_definition(definition1)
      expect(word.definition).to eq "fruit"
    end

    it "returns multiple definitions" do
      definition2 = Definition.new("edible")
      word.add_definition(definition2)
      expect(word.definition).to eq "fruit | edible"
    end

    it "returns long definitions" do
      definition3 = Definition.new("falls from trees")
      word.add_definition(definition3)
      expect(word.definition).to eq "fruit | edible | falls from trees"
    end
  end

end

describe "Definition" do

  let(:definition) { Definition.new("it does things") }

  describe "#describe" do
    it "returns its definition" do
      expect(definition.describe).to eq "it does things"
    end
  end
  
end

describe "Dictionary" do

  let(:word) { Word.new("apple") }

  after do
    Dictionary.empty
  end

  describe ".save" do
    it "saves a word in the dictionary" do
      Dictionary.save(word)
      expect(Dictionary.all_words).to eq [word]
    end
  end

  describe ".empty" do
    it "empties the dictionary of words" do
      Dictionary.save(word)
      Dictionary.empty
      expect(Dictionary.all_words).to eq []
    end
  end
  

end
