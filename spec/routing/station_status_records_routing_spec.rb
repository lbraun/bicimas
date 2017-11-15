require "rails_helper"

RSpec.describe StationStatusRecordsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/station_status_records").to route_to("station_status_records#index")
    end

    it "routes to #new" do
      expect(:get => "/station_status_records/new").to route_to("station_status_records#new")
    end

    it "routes to #show" do
      expect(:get => "/station_status_records/1").to route_to("station_status_records#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/station_status_records/1/edit").to route_to("station_status_records#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/station_status_records").to route_to("station_status_records#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/station_status_records/1").to route_to("station_status_records#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/station_status_records/1").to route_to("station_status_records#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/station_status_records/1").to route_to("station_status_records#destroy", :id => "1")
    end

  end
end
