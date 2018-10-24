require 'rails_helper'

RSpec.describe "search_notes", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "searches among 3 notes and expects 1 result" do

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    note2 = Note.create(
      description: Faker::Lorem.paragraph
    )

    note3 = Note.create(
      description: Faker::Lorem.paragraph
    )

    visit "/notes/"
    #fill_in "#search_notes", :with => unique_lastname
    find('#search_inputs_search_term').set(note1.description)

    sleep 2
    page.save_screenshot('findnote31.png')

    expect(page).to have_content(note1.description)
    expect(page).to_not have_content(note2.description)
    expect(page).to_not have_content(note3.description)
  end

  it "searches among 3 notes and expects 3 results" do
    description = Faker::Lorem.unique.paragraph

    note1 = Note.create(
      description: description
    )

    note2 = Note.create(
      description: description
    )

    note3 = Note.create(
      description: description
    )

    visit "/notes/"
    #fill_in "#search_notes", :with => unique_lastname
    find('#search_inputs_search_term').set(description)

    expect(page).to have_content(note1.description)
    expect(page).to have_content(note2.description)
    expect(page).to have_content(note3.description)



  end

  it "searches among 3 notes and expects 0 results" do
    description = Faker::Lorem.unique.paragraph

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    note2 = Note.create(
      description: Faker::Lorem.paragraph
    )

    note3 = Note.create(
      description: Faker::Lorem.paragraph
    )

    visit "/notes/"
    #fill_in "#search_notes", :with => unique_lastname
    find('#search_inputs_search_term').set(description)

    expect(page).to_not have_content(note1.description)

    expect(page).to_not have_content(note2.description)

    expect(page).to_not have_content(note3.description)

  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
