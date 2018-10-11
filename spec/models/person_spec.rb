require 'rails_helper'

RSpec.describe Person, type: :model do

  it "is valid with email" do
    person = Person.new(email: Faker::Internet.email)

    expect(person).to be_valid
  end

  it "is not valid without email" do
    person = Person.new()

    expect(person).to_not be_valid
  end

end
