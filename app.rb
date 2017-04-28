require 'sinatra'
require 'sinatra/reloader'
require './lib/definer'
require 'pry'

use Rack::Session::Cookie

also_reload('lib/**/*.rb')

get('/') do
  @dictionary = Dictionary.all_words
  erb(:dictionary)
end

get("/words/add") do
  erb(:add)
end

post("/add_word") do
  params.fetch("word")
  word = Word.new(params.fetch("word"))
  definition = Definition.new(params.fetch("definition"))
  word.add_definition(definition)
  Dictionary.save(word)
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
  definition = Definition.new(params.fetch("definition"))
  word.add_definition(definition)
  @dictionary = Dictionary.all_words
  erb(:dictionary)
end

get("/words/delete") do
  Dictionary.delete_by_id(session[:id])
  @dictionary = Dictionary.all_words
  erb(:dictionary)
end

