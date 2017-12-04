require 'rails_helper'

RSpec.describe "station_status_records/edit", type: :view do
  before(:each) do
    @station = assign(:station_status_record, Station.create!)
    @station_status_record = assign(:station_status_record, StationStatusRecord.create!(
      :station_id => @station.id,
      :bikes_total => 1,
      :bikes_available => 1,
      :anchors => "MyString",
      :online => false,
      :ip => "MyString",
      :number_loans => 1
    ))
  end

  it "renders the edit station_status_record form" do
    render

    assert_select "form[action=?][method=?]", station_status_record_path(@station_status_record), "post" do

      assert_select "input[name=?]", "station_status_record[station_id]"

      assert_select "input[name=?]", "station_status_record[bikes_total]"

      assert_select "input[name=?]", "station_status_record[bikes_available]"

      assert_select "input[name=?]", "station_status_record[anchors]"

      assert_select "input[name=?]", "station_status_record[online]"

      assert_select "input[name=?]", "station_status_record[ip]"

      assert_select "input[name=?]", "station_status_record[number_loans]"
    end
  end
end
