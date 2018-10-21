require 'rails_helper'

RSpec.describe "tasks", :type => :feature do

  before(:each) do
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  let(:institution) do
     Institution.create(name: Faker::Address.community, description: Faker::Lorem.paragraph)
  end

  let(:task1) do
    {
      description: Faker::Lorem.paragraph,
      deadline: Faker::Time.between(DateTime.now, DateTime.now + 3.month),
      priority: [1,2,3].sample,
      assigned_to_user_id: User.all.pluck(:id).sample,
      status: Task.statuses.sample
    }
  end


  it "views a person and expects a task" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    task1 = Task.create(task1)
    task1.update(assigned_to_user_id: User.all.pluck(:id).sample)
    person.tasks << task1

    visit "/people/#{person.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".person-#{person.id}-tasks" do
      expect(page).to have_content(task1.description)
      page.save_screenshot('task-person-expect.png')
      expect(page).to have_content(task1.deadline)
      expect(page).to have_content(task1.priority)
      expect(page).to have_content(User.find(task1.assigned_to_user_id).username)
      expect(page).to have_content(task1.status)
    end

  end

  it "views a person and adds task" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    description = Faker::Lorem.paragraph

    visit "/people/#{person.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".person-#{person.id}-tasks" do
      expect(page).to have_content("Keine Aufgaben vorhanden.")
    end

    expect(page).to have_css(".person-#{person.id}-tasks-new")

    within ".person-#{person.id}-tasks-new" do
      fill_in "Beschreibung", :with => description
      click_button "Aufgabe erstellen"
    end

    within ".person-#{person.id}-tasks" do
      expect(page).to have_content(description)
    end

  end

  it "views a person and adds a second task" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    task1 = Task.create(
      description: Faker::Lorem.paragraph
    )

    person.tasks << task1
    person.save

    description = Faker::Lorem.paragraph

    visit "/people/#{person.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".person-#{person.id}-tasks" do
      expect(page).to have_content(task1.description)
    end

    expect(page).to have_css(".person-#{person.id}-tasks-new")

    within ".person-#{person.id}-tasks-new" do
      fill_in "Beschreibung", :with => description
      click_button "Aufgabe erstellen"
    end

    within ".person-#{person.id}-tasks" do
      expect(page).to have_content(task1.description)
      expect(page).to have_content(description)
    end

  end

  it "views a person and deletes a task" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    task1 = Task.create(
      description: Faker::Lorem.paragraph
    )

    person.tasks << task1
    person.save

    visit "/people/#{person.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".person-#{person.id}-tasks" do
      expect(page).to have_content(task1.description)
    end

    find(".task-#{task1.id}-delete").click

    page.evaluate_script('window.confirm = function() { return true; }')

    within ".person-#{person.id}-tasks" do
      expect(page).to_not have_content(task1.description)
    end

    expect { Task.find(task1.id)}.to raise_error ActiveRecord::RecordNotFound

  end

  it "views an institution and expects a task" do

    task1 = Task.create(
      description: Faker::Lorem.paragraph
    )

    institution.tasks << task1
    institution.save

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".institution-#{institution.id}-tasks" do
      expect(page).to have_content(task1.description)
    end

  end

  it "views a institution and adds task" do

    description = Faker::Lorem.paragraph

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".institution-#{institution.id}-tasks" do
      expect(page).to have_content("Keine Aufgaben vorhanden.")
    end

    expect(page).to have_css(".institution-#{institution.id}-tasks-new")

    within ".institution-#{institution.id}-tasks-new" do
      fill_in "Beschreibung", :with => description
      click_button "Aufgabe erstellen"
    end

    within ".institution-#{institution.id}-tasks" do
      expect(page).to have_content(description)
    end

  end

  it "views a institution and adds a second task" do

    task1 = Task.create(
      description: Faker::Lorem.paragraph
    )

    institution.tasks << task1
    institution.save

    description = Faker::Lorem.paragraph

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".institution-#{institution.id}-tasks" do
      expect(page).to have_content(task1.description)
    end

    expect(page).to have_css(".institution-#{institution.id}-tasks-new")

    within ".institution-#{institution.id}-tasks-new" do
      fill_in "Beschreibung", :with => description
      click_button "Aufgabe erstellen"
    end

    within ".institution-#{institution.id}-tasks" do
      expect(page).to have_content(task1.description)
      expect(page).to have_content(description)
    end

  end

  it "views a institution and deletes a task" do

    task1 = Task.create(
      description: Faker::Lorem.paragraph
    )

    institution.tasks << task1
    institution.save

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Aufgaben anzeigen")

    click_link "Aufgaben anzeigen"

    within ".institution-#{institution.id}-tasks" do
      expect(page).to have_content(task1.description)
    end

    find(".task-#{task1.id}-delete").click

    page.evaluate_script('window.confirm = function() { return true; }')

    within ".institution-#{institution.id}-tasks" do
      expect(page).to_not have_content(task1.description)
    end

    expect { Task.find(task1.id)}.to raise_error ActiveRecord::RecordNotFound

  end


end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
