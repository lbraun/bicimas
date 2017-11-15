require 'rails_helper'

RSpec.describe "stations/edit", type: :view do
  before(:each) do
    @station = assign(:station, Station.create!(
      :number => 1,
      :coordinate_x => "9.99",
      :coordinate_y => "9.99",
      :name => "MyString"
    ))
  end

  it "renders the edit station form" do
    render

    assert_select "form[action=?][method=?]", station_path(@station), "post" do

      assert_select "input[name=?]", "station[number]"

      assert_select "input[name=?]", "station[coordinate_x]"

      assert_select "input[name=?]", "station[coordinate_y]"

      assert_select "input[name=?]", "station[name]"
    end
  end
end
