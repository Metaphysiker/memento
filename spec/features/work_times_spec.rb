require 'rails_helper'

RSpec.describe "work_times", :type => :feature do

  before(:each) do
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  let(:work_time1) do
    {
      date: Date.today,
      task: "Telefonieren",
      area: "Memento",
      project: "Verein",
      voluntary: false,
      time: 2.5
    }
  end

  it "creates a worktime" do
    visit "/my_worktime"
    #click_button "Person erstellen"

    user = first_user.name
    date = Date.today
    time = 2.5
    task = "Memento upgedatet und aktualisiert"
    area = WorkTime.areas.first
    project = WorkTime.projects.first
    #voluntary

    fill_in "User", :with => firstname
    fill_in "Zeit", :with => time
    fill_in "Aufgabe", :with => task
    fill_in "Bereich", :with => area
    fill_in "Projekt", :with => project

    within(".form-actions") do
      click_button "Arbeitszeit erstellen"
    end

    fill_in "User", :with => firstname
    fill_in "Zeit", :with => time
    fill_in "Aufgabe", :with => task
    fill_in "Bereich", :with => area
    fill_in "Projekt", :with => project

    expect(page).to have_content(firstname)
    expect(page).to have_content(time)
    expect(page).to have_content(task)
    expect(page).to have_content(area)
    expect(page).to have_content(project)
  end


end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
