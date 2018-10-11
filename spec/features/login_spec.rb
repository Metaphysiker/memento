require 'rails_helper'

RSpec.describe "login", :type => :feature do

  it "displays the user's username after successful login with username" do
    user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    visit "/users/sign_in"
    fill_in "Login", :with => user.username
    fill_in "Passwort", :with => "secret"
    click_button "Log in"

    expect(page).to have_selector(".navbar-brand", :text => user.username)
  end

  it "displays the user's username after a successful login with email" do
    user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    visit "/users/sign_in"
    fill_in "Login", :with => user.email
    fill_in "Passwort", :with => "secret"
    click_button "Log in"

    expect(page).to have_selector(".navbar-brand", :text => user.username)
  end

  it "redirect if unauthorized user tries to login with username" do
    user = User.create!(:username => Faker::Internet.username, :email => Faker::Internet.email, :password => "secret")
    visit "/users/sign_in"
    fill_in "Login", :with => user.username
    fill_in "Passwort", :with => "secret"
    click_button "Log in"

    #expect{Object.public_instance_methods}.to raise_error(RuntimeError)
    expect(page).to have_content("Sie sind nicht authorisiert!")

  end

  it "redirect if unauthorized user tries to login with email" do
    user = User.create!(:username => Faker::Internet.username, :email => Faker::Internet.email, :password => "secret")
    visit "/users/sign_in"
    fill_in "Login", :with => user.email
    fill_in "Passwort", :with => "secret"
    click_button "Log in"

    expect(page).to have_content("Sie sind nicht authorisiert!")
  end

  it "it displays sign in after a unsuccessful login with email" do
    user = User.create!(:username => Faker::Internet.username, :email => Faker::Internet.email, :password => "secret")
    visit "/users/sign_in"
    fill_in "Login", :with => "x" + "user.email"
    fill_in "Passwort", :with => "secret"
    click_button "Log in"

    expect(page).to have_content("Login oder Passwort ungültig.")
    #expect(page).to have_selector(".navbar-brand", :text => "Login oder Passwort ungültig.")
  end

  it "it displays sign in after a unsuccessful login with username" do
    user = User.create!(:username => Faker::Internet.username, :email => Faker::Internet.email, :password => "secret")
    visit "/users/sign_in"
    fill_in "Login", :with => "x" + "user.username"
    fill_in "Passwort", :with => "secret"
    click_button "Log in"

    expect(page).to have_content("Login oder Passwort ungültig.")
    #expect(page).to have_selector(".navbar-brand", :text => "Login oder Passwort ungültig.")
  end

end

def login
  user = User.create!(:username => Faker::Internet.username, :email => Faker::Internet.email, :password => "secret")
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
