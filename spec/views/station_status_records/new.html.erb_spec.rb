require 'rails_helper'

RSpec.describe "station_status_records/new", type: :view do
  before(:each) do
    assign(:station_status_record, StationStatusRecord.new(
      :station_id => 1,
      :bikes_total => 1,
      :bikes_available => 1,
      :anchors => "MyString",
      :online => false,
      :ip => "MyString",
      :number_loans => 1
    ))
  end

  it "renders new station_status_record form" do
    render

    assert_select "form[action=?][method=?]", station_status_records_path, "post" do

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
