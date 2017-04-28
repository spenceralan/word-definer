require "definer"
require "rspec"
require "pry"

describe "Word" do
  let (:apple) { Word.new("apple") }
  let (:orange) { Word.new("orange") }

  describe "#describe" do
    it "returns the word" do
      expect(apple.describe).to eq "apple"
    end

    describe "#id" do
      it "generates a uuid as an id" do
        expect(apple.id).to be_a String
      end
    
      it "uuids between different objects are unique" do
        expect(apple.id).to_not eq orange.id
      end
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

  before do
    Dictionary.save(word)
  end

  after do
    Dictionary.empty
  end

  describe ".save" do
    it "saves a word in the dictionary" do
      expect(Dictionary.all_words).to eq [word]
    end
  end

  describe ".empty" do
    it "empties the dictionary of words" do
      Dictionary.empty
      expect(Dictionary.all_words).to eq []
    end
  end

  describe ".find_by_id" do
    it "returns word object given the words id" do
      id = word.id
      expect(Dictionary.find_by_id(id)).to eq word
    end
  end
  

end
