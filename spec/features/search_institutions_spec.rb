require 'rails_helper'

RSpec.describe "search_institutions", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "searches among 3 institutions and expects 1 result" do

    institution1 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    institution2 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    institution3 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    visit "/institutions/"
    #fill_in "#search_institutions", :with => unique_lastname
    find('#search_institutions').set(institution1.name)

    expect(page).to have_content(institution1.name)
    expect(page).to have_content(institution1.email)
    expect(page).to have_content(institution1.description)

    expect(page).to_not have_content(institution2.name)
    expect(page).to_not have_content(institution2.email)
    expect(page).to_not have_content(institution2.description)

    expect(page).to_not have_content(institution3.name)
    expect(page).to_not have_content(institution3.email)
    expect(page).to_not have_content(institution3.description)
  end

  it "searches among 3 institutions and expects 3 results" do
    name = Faker::Name.unique.name

    institution1 = Institution.create(
      name: name + "a",
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    institution2 = Institution.create(
      name: name + "b",
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    institution3 = Institution.create(
      name: name + "c",
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    visit "/institutions/"
    #fill_in "#search_institutions", :with => unique_lastname
    find('#search_institutions').set(name)

    expect(page).to have_content(institution1.name)
    expect(page).to have_content(institution1.email)
    expect(page).to have_content(institution1.description)

    expect(page).to have_content(institution2.name)
    expect(page).to have_content(institution2.email)
    expect(page).to have_content(institution2.description)

    expect(page).to have_content(institution3.name)
    expect(page).to have_content(institution3.email)
    expect(page).to have_content(institution3.description)



  end

  it "searches among 3 institutions and expects 0 results" do
    unique_name = Faker::Name.unique.name

    institution1 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    institution2 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    institution3 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    visit "/institutions/"
    #fill_in "#search_institutions", :with => unique_lastname
    find('#search_institutions').set(unique_name)

    expect(page).to_not have_content(institution1.name)
    expect(page).to_not have_content(institution1.email)
    expect(page).to_not have_content(institution1.description)

    expect(page).to_not have_content(institution2.name)
    expect(page).to_not have_content(institution2.email)
    expect(page).to_not have_content(institution2.description)

    expect(page).to_not have_content(institution3.name)
    expect(page).to_not have_content(institution3.email)
    expect(page).to_not have_content(institution3.description)

  end


  it "searches with description and expect 1 result" do
    institution1 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.unique.paragraph,
      email:Faker::Internet.unique.email
    )

    institution2 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    institution3 = Institution.create(
      name: Faker::Name.unique.name,
      description: Faker::Lorem.paragraph,
      email:Faker::Internet.unique.email
    )

    visit "/institutions/"
    #fill_in "#search_institutions", :with => unique_lastname
    find('#search_institutions').set(institution1.description)

    expect(page).to have_content(institution1.name)
    expect(page).to have_content(institution1.email)
    expect(page).to have_content(institution1.description)

    expect(page).to_not have_content(institution2.name)
    expect(page).to_not have_content(institution2.email)
    expect(page).to_not have_content(institution2.description)

    expect(page).to_not have_content(institution3.name)
    expect(page).to_not have_content(institution3.email)
    expect(page).to_not have_content(institution3.description)
  end



end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
