require "capybara/rspec"
require "./app"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("the word path", {:type => :feature}) do

  after do
    Dictionary.empty
  end

  it("processes the user input and adds the word to the dictionary") do
    visit("/")
    click_link("add word")
    fill_in("word", :with => "happy")
    fill_in("definition", :with => "pants")
    click_button("add word")
    expect(page).to have_content("happy")
    expect(page).to have_content("pants")
  end

  it("did not add the word to the dictionary if the user clicked the back button") do
    visit("/")
    click_link("add word")
    fill_in("word", :with => "happy")
    fill_in("definition", :with => "pants")
    click_link("back")
    expect(page).not_to have_content("happy")
    expect(page).not_to have_content("pants")
  end

  it("processes the user input and deletes a word from the dictionary") do
    visit("/")
    click_link("add word")
    fill_in("word", :with => "happy")
    fill_in("definition", :with => "pants")
    click_button("add word")
    click_link("happy")
    fill_in("definition", :with => "smarty")
    click_button("add definition")
    expect(page).to have_content("pants | smarty")
  end

  it("processes the user input and adds a second definition to the word") do
    visit("/")
    click_link("add word")
    fill_in("word", :with => "happy")
    fill_in("definition", :with => "pants")
    click_button("add word")
    click_link("happy")
    click_link("delete word")
    expect(page).not_to have_content("happy")
    expect(page).not_to have_content("pants")
  end
end
