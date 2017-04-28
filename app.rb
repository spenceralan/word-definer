require 'sinatra'
require 'sinatra/reloader'
require './lib/definer'
require 'pry'

use Rack::Session::Cookie, :secret => '877de719-65d4-4f40-83bf-3b83d56d40db'

also_reload('lib/**/*.rb')

get('/') do
  @dictionary = Dictionary.all_words
  erb(:dictionary)
end

get("/words/add") do
  erb(:add)
end

post("/add_word") do
  user_input_word = params.fetch("word")
  user_input_definition = params.fetch("definition")

  unless user_input_word.match?(/\A\s*\z/)
    word = Word.new(user_input_word)
    unless user_input_definition.match?(/\A\s*\z/)
      definition = Definition.new(user_input_definition)
      word.add_definition(definition)
    end
    Dictionary.save(word)
  end

  @dictionary = Dictionary.all_words
  erb(:dictionary)
end

get("/modify_word/:id") do
  session[:id] = params.fetch("id")
  @word = Dictionary.find_by_id(session[:id])
  erb(:edit)
end

post("/update_word") do
  word = Dictionary.find_by_id(session[:id])
  user_input_definition = params.fetch("definition")

  unless user_input_definition.match?(/\A\s*\z/)
    definition = Definition.new(user_input_definition)
    word.add_definition(definition)
  end

  @dictionary = Dictionary.all_words
  erb(:dictionary)
end

get("/words/delete") do
  Dictionary.delete_by_id(session[:id])
  @dictionary = Dictionary.all_words
  erb(:dictionary)
end

