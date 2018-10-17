require 'rails_helper'


RSpec.describe Institution, type: :model do

  it "is valid with name" do
    institution = Institution.new(name: Faker::Address.community)

    expect(institution).to be_valid
  end

  it "is not valid without name" do
    institution = Institution.new()

    expect(institution).to_not be_valid
  end

end
