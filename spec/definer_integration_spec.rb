require "capybara/rspec"
require "./app"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("the add word path", {:type => :feature}) do

  after do
    Dictionary.empty
  end

  it("processes the user input and adds the word to the dictionary") do
    visit("/")
    click_link("add word")
    fill_in("word", :with => "word")
    fill_in("definition", :with => "definition")
    click_button("add word")
    expect(page).to have_content("word")
    expect(page).to have_content("definition")
  end

  it("processes the user input and adds the word to the dictionary") do
    visit("/")
    click_link("add word")
    fill_in("word", :with => "word")
    fill_in("definition", :with => "definition")
    click_button("add word")
    expect(page).to have_content("word")
    expect(page).to have_content("definition")
  end
end
