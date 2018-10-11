require 'rails_helper'

RSpec.describe "people/edit", type: :view do
  before(:each) do
    @person = assign(:person, Person.create!(
      :firstname => "MyString",
      :lastname => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :philosophie_id => 1,
      :login => "MyString"
    ))
  end

  it "renders the edit person form" do
    render

    assert_select "form[action=?][method=?]", person_path(@person), "post" do

      assert_select "input[name=?]", "person[firstname]"

      assert_select "input[name=?]", "person[lastname]"

      assert_select "input[name=?]", "person[email]"

      assert_select "input[name=?]", "person[phone]"

      assert_select "input[name=?]", "person[philosophie_id]"

      assert_select "input[name=?]", "person[login]"
    end
  end
end
