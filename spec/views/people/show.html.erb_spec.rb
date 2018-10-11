require 'rails_helper'

RSpec.describe "people/show", type: :view do
  before(:each) do
    @person = assign(:person, Person.create!(
      :firstname => "Firstname",
      :lastname => "Lastname",
      :email => "Email",
      :phone => "Phone",
      :philosophie_id => 2,
      :login => "Login"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Login/)
  end
end
