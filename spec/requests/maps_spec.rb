require 'rails_helper'

describe "Maps", type: :request do
  describe "GET /maps" do
    it "#index success" do
      get maps_path, format: :text
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /maps/:id" do
    it "#show success" do
      get maps_path, id: "MyMap", format: :text
      expect(response).to have_http_status(200)
    end
  end
end
