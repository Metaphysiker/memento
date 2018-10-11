require 'rails_helper'

RSpec.describe User, type: :model do

  it "is not valid without email" do
    user = User.new(username: Faker::Internet.username, password: "secret")

    expect(user).to_not be_valid
  end

  it "is not valid without username" do
    user = User.new(email: Faker::Internet.email, password: "secret")

    expect(user).to_not be_valid
  end

  it "is valid with username and email" do
    user = User.new(email: Faker::Internet.email, username: Faker::Internet.username, password: "secret")

    expect(user).to be_valid
  end

end
