require 'rails_helper'

RSpec.describe "login", :type => :feature do
  it "displays the user's username after successful login" do
    login
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
