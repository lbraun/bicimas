require 'rails_helper'

RSpec.describe "stations/show", type: :view do
  before(:each) do
    @station = assign(:station, Station.create!(
      :number => 2,
      :coordinate_x => "9.99",
      :coordinate_y => "9.99",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Name/)
  end
end
