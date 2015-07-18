require "rails_helper"

describe MapsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/maps").to route_to("maps#index")
    end

    it "routes to #show" do
      expect(get: "/maps/mymap").to route_to("maps#show", id: "mymap")
    end

    it "routes to #create" do
      expect(post: "/maps/mymap").to route_to("maps#create", id: "mymap")
    end

    it "routes to #update via PUT" do
      expect(put: "/maps/mymap").to route_to("maps#update", id: "mymap")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/maps/mymap").to route_to("maps#update", id: "mymap")
    end

    it "routes to #destroy" do
      expect(delete: "/maps/mymap").to route_to("maps#destroy", id: "mymap")
    end

    it "routes to #search" do
      expect(post: "/maps/mymap/search").to route_to("maps#search", id: "mymap")
    end
  end
end
