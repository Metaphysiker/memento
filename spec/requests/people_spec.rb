require 'rails_helper'

RSpec.describe "People", type: :request do
  describe "GET /people" do
    it "works! (now write some real specs)" do
      pending
      get people_path
      expect(response).to have_http_status(200)
    end
  end
end
