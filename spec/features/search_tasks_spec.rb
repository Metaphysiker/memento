require 'rails_helper'

RSpec.describe "search_tasks", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  let(:person) do
    Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
  end

  it "searches among 3 tasks and expects 1 result" do

    task1 = Task.create(
      description: Faker::Lorem.unique.paragraph
    )

    task2 = Task.create(
      description: Faker::Lorem.unique.paragraph
    )

    task3 = Task.create(
      description: Faker::Lorem.unique.paragraph
    )

    person.tasks << [task1, task2, task3]
    person.save

    visit "/tasks/"
    #fill_in "#search_tasks", :with => unique_lastname
    find('#search_inputs_search_term').set(task1.description)

    expect(page).to have_content(task1.description)
    expect(page).to_not have_content(task2.description)
    expect(page).to_not have_content(task3.description)
  end

  it "searches among 3 tasks and expects 3 results" do
    description = Faker::Lorem.unique.paragraph

    task1 = Task.create(
      description: description
    )

    task2 = Task.create(
      description: description
    )

    task3 = Task.create(
      description: description
    )

    person.tasks << [task1, task2, task3]
    person.save

    visit "/tasks/"
    #fill_in "#search_tasks", :with => unique_lastname
    find('#search_inputs_search_term').set(description)

    expect(page).to have_content(task1.description)
    expect(page).to have_content(task2.description)
    expect(page).to have_content(task3.description)



  end

  it "searches among 3 tasks and expects 0 results" do
    description = Faker::Lorem.unique.paragraph

    task1 = Task.create(
      description: Faker::Lorem.paragraph
    )

    task2 = Task.create(
      description: Faker::Lorem.paragraph
    )

    task3 = Task.create(
      description: Faker::Lorem.paragraph
    )

    visit "/tasks/"
    #fill_in "#search_tasks", :with => unique_lastname
    find('#search_inputs_search_term').set(description)

    expect(page).to_not have_content(task1.description)

    expect(page).to_not have_content(task2.description)

    expect(page).to_not have_content(task3.description)

  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
