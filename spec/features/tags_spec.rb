require 'rails_helper'

RSpec.describe "tags", :type => :feature do

  before(:each) do
    tags = ["Sponsor", "Medienkontakt","Kooperationspartner", "Stiftungsmitglied",
            "Portalmitglied", "Veranstalter", "Lehrperson", "Öffentliche Institution",
          "Blogger", "Platinmitglied", "200er-Mitglied", "Patronatskomitee"]

    tags.each do |tag|
      TagList.create(
        name: tag
      )
    end
  end

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "views a person and expects tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    tag1 = TagList.first.name
    person.tag_list.add(tag1)

    tag2 = TagList.second.name
    person.tag_list.add(tag2)
    person.save

    visit "/people/#{person.id}"

    within ".person-#{person.id}-tags" do
      expect(page).to have_content(tag1)
      expect(page).to have_content(tag2)
    end

  end

  it "views a person, adds tags and expects tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    tag1 = TagList.first.name

    tag2 = TagList.second.name

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    select_from_chosen(tag1, from: 'person_tag_list')
    select_from_chosen(tag2, from: 'person_tag_list')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-tags" do
      expect(page).to have_content(tag1)
      expect(page).to have_content(tag2)
    end

  end

  it "views a person, remove tags and expects no tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    tag1 = TagList.first.name
    person.tag_list.add(tag1)

    tag2 = TagList.second.name
    person.tag_list.add(tag2)
    person.save

    visit "/people/#{person.id}"

    within ".person-#{person.id}-tags" do
      expect(page).to have_content(tag1)
      expect(page).to have_content(tag2)
    end

    find(".person-#{person.id}-edit").click

    remove_from_chosen(tag1, from: 'person_tag_list')
    remove_from_chosen(tag2, from: 'person_tag_list')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-tags" do
      expect(page).to_not have_content(tag1)
      expect(page).to_not have_content(tag2)
    end
  end
end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
