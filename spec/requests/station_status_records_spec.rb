require 'rails_helper'

RSpec.describe "StationStatusRecords", type: :request do
  describe "GET /station_status_records" do
    it "works! (now write some real specs)" do
      get station_status_records_path
      expect(response).to have_http_status(200)
    end
  end
end
