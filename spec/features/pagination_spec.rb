require 'rails_helper'

RSpec.describe "pagination", :type => :feature do

  entries_per_page = 20

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end


  it "expects no pagination" do

    (entries_per_page-1).times.each do
      Person.create(
        email: Faker::Internet.email,
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        description: Faker::Lorem.paragraph,
        phone: Faker::PhoneNumber.cell_phone,
        gender: "male"
      )
    end

      visit "/people/"
      expect(page).to_not have_selector :css, '.pagination'
    end

    it "expects pagination" do

      (entries_per_page+1).times.each do
        Person.create(
          email: Faker::Internet.email,
          firstname: Faker::Name.first_name,
          lastname: Faker::Name.last_name,
          description: Faker::Lorem.paragraph,
          phone: Faker::PhoneNumber.cell_phone,
          gender: "male"
        )
      end

        visit "/people/"
        expect(page).to have_selector :css, '.pagination'
    end

    it "expects pagination with 3 pages" do

      (entries_per_page * 3).times.each do
        Person.create(
          email: Faker::Internet.email,
          firstname: Faker::Name.first_name,
          lastname: Faker::Name.last_name,
          description: Faker::Lorem.paragraph,
          phone: Faker::PhoneNumber.cell_phone,
          gender: "male"
        )
      end

        visit "/people/"
        expect(page).to have_selector :css, '.pagination'
        expect(page).to have_css('.page-link', text: 1)
        expect(page).to have_css('.page-link', text: 2)
        expect(page).to have_css('.page-link', text: 3)
        expect(page).to_not have_css('.page-link', text: 4)

    end

    it "expects pagination with 6 pages" do

      ((entries_per_page * 5)+1).times.each do
        Person.create(
          email: Faker::Internet.email,
          firstname: Faker::Name.first_name,
          lastname: Faker::Name.last_name,
          description: Faker::Lorem.paragraph,
          phone: Faker::PhoneNumber.cell_phone,
          gender: "male"
        )
      end

        visit "/people/"
        expect(page).to have_selector :css, '.pagination'
        expect(page).to have_css('.page-link', text: 1)
        expect(page).to have_css('.page-link', text: 2)
        expect(page).to have_css('.page-link', text: 3)
        expect(page).to have_css('.page-link', text: 6)
        expect(page).to_not have_css('.page-link', text: 7)

    end

    it "clicks through pagination" do

        entries_per_page.times.each do
        Person.create(
          email: Faker::Internet.email,
          firstname: "aaa@aaa@aa",
          lastname: Faker::Name.last_name,
          description: Faker::Lorem.paragraph,
          phone: Faker::PhoneNumber.cell_phone,
          gender: "male"
        )
      end

      entries_per_page.times.each do
        Person.create(
          email: Faker::Internet.email,
          firstname: "bbb@bbb@bb",
          lastname: Faker::Name.last_name,
          description: Faker::Lorem.paragraph,
          phone: Faker::PhoneNumber.cell_phone,
          gender: "male"
        )
      end

      entries_per_page.times.each do
        Person.create(
          email: Faker::Internet.email,
          firstname: "ccc@ccc@cc",
          lastname: Faker::Name.last_name,
          description: Faker::Lorem.paragraph,
          phone: Faker::PhoneNumber.cell_phone,
          gender: "male"
        )
      end

        visit "/people/"

        expect(page).to have_selector :css, '.pagination'

        expect(page).to have_content("aaa@aaa@aa")
        expect(page).to_not have_content("bbb@bbb@bb")
        expect(page).to_not have_content("ccc@ccc@cc")

        first('.page-link', text: 2).click


        expect(page).to_not have_content("aaa@aaa@aa")
        expect(page).to have_content("bbb@bbb@bb")
        expect(page).to_not have_content("ccc@ccc@cc")

        first('.page-link', text: 3).click

        expect(page).to_not have_content("aaa@aaa@aa")
        expect(page).to_not have_content("bbb@bbb@bb")
        expect(page).to have_content("ccc@ccc@cc")

    end

    it "clicks through pagination in institutions" do

        entries_per_page.times.each do
          Institution.create(name: "aaa#{Faker::Name.unique.last_name}",
                              description: "aaa"
                            )
        end

        entries_per_page.times.each do
          Institution.create(name: "bbb#{Faker::Name.unique.last_name}",
                              description: "bbb"
                            )
        end

        entries_per_page.times.each do
          Institution.create(name: "ccc#{Faker::Name.unique.last_name}",
                              description: "ccc"
                            )
        end


        visit "/institutions/"

        expect(page).to have_selector :css, '.pagination'

        expect(page).to have_content("aaa")
        expect(page).to_not have_content("bbb")
        expect(page).to_not have_content("ccc")

        first('.page-link', text: 2).click


        expect(page).to_not have_content("aaa")
        expect(page).to have_content("bbb")
        expect(page).to_not have_content("ccc")

        first('.page-link', text: 3).click

        expect(page).to_not have_content("aaa")
        expect(page).to_not have_content("bbb")
        expect(page).to have_content("ccc")

    end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
