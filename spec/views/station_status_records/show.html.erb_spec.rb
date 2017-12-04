require 'rails_helper'

RSpec.describe "station_status_records/show", type: :view do
  before(:each) do
    station = Station.create!
    @station_status_record = assign(:station_status_record, StationStatusRecord.create!(
      :station_id => station.id,
      :bikes_total => 3,
      :bikes_available => 4,
      :anchors => "[{\"number\"=>1, \"bicycle\"=>nil, \"incidents\"=>[]}]",
      :online => false,
      :ip => "Ip",
      :number_loans => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Anchors/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Ip/)
    expect(rendered).to match(/5/)
  end
end
