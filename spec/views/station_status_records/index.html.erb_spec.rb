require 'rails_helper'

RSpec.describe "station_status_records/index", type: :view do
  before(:each) do
    assign(:station_status_records, [
      StationStatusRecord.create!(
        :station_id => 2,
        :bikes_total => 3,
        :bikes_available => 4,
        :anchors => "Anchors",
        :online => false,
        :ip => "Ip",
        :number_loans => 5
      ),
      StationStatusRecord.create!(
        :station_id => 2,
        :bikes_total => 3,
        :bikes_available => 4,
        :anchors => "Anchors",
        :online => false,
        :ip => "Ip",
        :number_loans => 5
      )
    ])
  end

  it "renders a list of station_status_records" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Anchors".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
