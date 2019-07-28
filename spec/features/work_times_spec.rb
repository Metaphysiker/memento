require 'rails_helper'

RSpec.describe "work_times", :type => :feature do

  before(:each) do
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    @first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(@first_user)
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

    username = @first_user.username
    date = Date.today
    time = 2.5
    task = "Memento upgedatet und aktualisiert"
    area = WorkTime.areas.sample
    project = WorkTime.projects.sample
    #voluntary

    select username, :from => 'User'
    select date.day, :from => "work_time_date_3i"
    select I18n.t("date.month_names")[date.month], :from => "work_time_date_2i"
    select date.year, :from => "work_time_date_1i"
    fill_in "Zeit", :with => time
    fill_in "Aufgabe", :with => task
    select area.downcase.titleize, :from => 'Bereich'
    select project.downcase.titleize, :from => 'Projekt'

    within(".form-actions") do
      click_button "Arbeitszeit erstellen"
    end

    expect(page).to have_content(username)
    expect(page).to have_content(time)
    expect(page).to have_content(task)
    expect(page).to have_content(area)
    expect(page).to have_content(project)
    #page.save_screenshot('worktimecreated.png')
  end


end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
