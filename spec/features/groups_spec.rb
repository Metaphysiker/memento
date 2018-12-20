require 'rails_helper'

RSpec.describe "groups", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "creates a group" do

    name = Faker::Demographic.educational_attainment
    description = Faker::Lorem.paragraph

    visit "/groups/"
    click_button "Gruppe erstellen"
    fill_in "Name", :with => name
    fill_in "Beschreibung", :with => description

    within('.group--edit-modal') do
      click_button "Gruppe erstellen"
    end

    expect(page).to have_content(name)
    expect(page).to have_content(description)
    #page.save_screenshot('gruppe-erstellen.png')
  end

  it "deletes a group" do

    name = Faker::Demographic.educational_attainment
    description = Faker::Lorem.paragraph

    group = Group.create(name: name, description: description)

    visit "/groups/#{group.id}"
    expect(page).to have_content(name)
    expect(page).to have_content(description)

    find(".group-#{group.id}-delete").click
    page.evaluate_script('window.confirm = function() { return true; }')
    expect(page).to_not have_content(name)
    expect(page).to_not have_content(description)
  end

  it "updates a group" do

    name = Faker::Demographic.educational_attainment
    description = Faker::Lorem.paragraph

    name2 = Faker::Demographic.educational_attainment
    description2 = Faker::Lorem.paragraph

    group = Group.create(name: name, description: description)

    visit "/groups/#{group.id}"
    expect(page).to have_content(name)
    expect(page).to have_content(description)

    find(".group-#{group.id}-edit").click
    fill_in "Name", :with => name2
    fill_in "Beschreibung", :with => description2
    click_button "Gruppe aktualisieren"

    expect(page).to_not have_content(name)
    expect(page).to_not have_content(description)
    expect(page).to have_content(name2)
    expect(page).to have_content(description2)


  end
end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
