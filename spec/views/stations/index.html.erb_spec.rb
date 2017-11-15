require 'rails_helper'

RSpec.describe 'stations/index', type: :view do
  before(:each) do
    assign(:stations, [
      Station.create!(
        number: 2,
        coordinate_x: '8.88',
        coordinate_y: '9.99',
        name: 'Name'
      ),
      Station.create!(
        number: 2,
        coordinate_x: '8.88',
        coordinate_y: '9.99',
        name: 'Name'
      )
    ])
  end

  it 'renders a list of stations' do
    render
    save_and_open_rendered
    assert_select 'tr>td', text: '2', count: 2
    assert_select 'tr>td', text: '8.88', count: 2
    assert_select 'tr>td', text: '9.99', count: 2
    assert_select 'tr>td', text: 'Name', count: 2
  end
end
