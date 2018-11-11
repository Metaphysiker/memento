require 'rails_helper'

RSpec.describe "tags", :type => :feature do

  before(:each) do
    person_functionality_tags = ["Sponsor", "Medienkontakt","Kooperationspartner", "Stiftungsmitglied",
            "Portalmitglied", "Veranstalter", "Lehrperson", "Öffentliche Institution",
          "Blogger", "Platinmitglied", "200er-Mitglied", "Patronatskomitee"]

    person_functionality_tags.each do |tag|
      TagList.create(
        name: tag,
        category: "functionality",
        model: "Person"
      )
    end

    person_target_groups_tags = ["Kinder", "Schüler","Studierende", "Uni-Mitarbeitende",
            "Gymnasiallehrperson", "Private", "Beruffachleute", "Medienfachleute",
          "Mitglieder Verein", "ehrenamtliche Blogger"]

    person_target_groups_tags.each do |tag|
      TagList.create(
        name: tag,
        category: "target_group",
        model: "Person"
      )
    end
  end

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "views a person and expects functionality and target group tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    ftag = TagList.where(model: "Person", category: "functionality").sample
    person.functionality_list.add(ftag)

    ttag = TagList.where(model: "Person", category: "target_group").sample
    person.target_group_list.add(ttag)
    person.save

    visit "/people/#{person.id}"

    within ".person-#{person.id}-functionality-tags" do
      expect(page).to have_content(ftag)
    end

    within ".person-#{person.id}-target-group-tags" do
      expect(page).to have_content(ttag)
    end

  end

  it "views a person, adds and expects functionality and target group tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    ftag = TagList.where(model: "Person", category: "functionality").sample

    ttag = TagList.where(model: "Person", category: "target_group").sample

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click
    select_from_chosen(ftag.name, from: 'person_functionality_list')
    select_from_chosen(ttag.name, from: 'person_target_group_list')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-functionality-tags" do
      expect(page).to have_content(ftag.name)
    end

    within ".person-#{person.id}-target-group-tags" do
      expect(page).to have_content(ttag.name)
    end

  end

  it "views a person, adds and expects 5 functionality and target group tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    TagList.where(model: "Person", category: "functionality").first(5).each do |ftag|
      select_from_chosen(ftag.name, from: 'person_functionality_list')
    end

    TagList.where(model: "Person", category: "target_group").first(5).each do |ttag|
      select_from_chosen(ttag.name, from: 'person_target_group_list')
    end

    click_button "Person aktualisieren"

    within ".person-#{person.id}-functionality-tags" do
      TagList.where(model: "Person", category: "functionality").first(5).each do |ftag|
        expect(page).to have_content(ftag.name)
      end
    end

    within ".person-#{person.id}-target-group-tags" do
      TagList.where(model: "Person", category: "target_group").first(5).each do |ttag|
        expect(page).to have_content(ttag.name)
      end
    end

  end

  it "views a person, removes and expects 0 functionality and target group tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    ftag = TagList.where(model: "Person", category: "functionality").sample

    ttag = TagList.where(model: "Person", category: "target_group").sample

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click
    select_from_chosen(ftag.name, from: 'person_functionality_list')
    select_from_chosen(ttag.name, from: 'person_target_group_list')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-functionality-tags" do
      expect(page).to have_content(ftag.name)
    end

    within ".person-#{person.id}-target-group-tags" do
      expect(page).to have_content(ttag.name)
    end

    find(".person-#{person.id}-edit").click

    remove_from_chosen(ftag.name, from: 'person_functionality_list')
    remove_from_chosen(ttag.name, from: 'person_target_group_list')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-functionality-tags" do
      expect(page).to_not have_content(ftag.name)
    end

    within ".person-#{person.id}-target-group-tags" do
      expect(page).to_not have_content(ttag.name)
    end

  end

  it "creates a tag" do
    name = Faker::Lorem.word
    tag_count = TagList.count

    visit "/tag_lists/"
    click_button "Tag erstellen"



    fill_in "Name", :with => name

    within(".form-actions") do
      click_button "Tag erstellen"
    end

    expect(page).to have_content(name)
    expect(TagList.count == tag_count + 1).to be(true)
  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
