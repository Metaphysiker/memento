require "rails_helper"

RSpec.describe TagListsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tag_lists").to route_to("tag_lists#index")
    end

    it "routes to #new" do
      expect(:get => "/tag_lists/new").to route_to("tag_lists#new")
    end

    it "routes to #show" do
      expect(:get => "/tag_lists/1").to route_to("tag_lists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tag_lists/1/edit").to route_to("tag_lists#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tag_lists").to route_to("tag_lists#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tag_lists/1").to route_to("tag_lists#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tag_lists/1").to route_to("tag_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tag_lists/1").to route_to("tag_lists#destroy", :id => "1")
    end
  end
end
