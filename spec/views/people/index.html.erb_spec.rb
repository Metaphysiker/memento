require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before(:each) do
    assign(:people, [
      Person.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email",
        :phone => "Phone",
        :philosophie_id => 2,
        :login => "Login"
      ),
      Person.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email",
        :phone => "Phone",
        :philosophie_id => 2,
        :login => "Login"
      )
    ])
  end

end
