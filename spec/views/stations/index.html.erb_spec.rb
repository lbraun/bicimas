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
        number: 3,
        coordinate_x: '8.88',
        coordinate_y: '9.99',
        name: 'Name'
      )
    ])
  end

  it 'renders a list of stations' do
    render
    assert_select 'tr>td', text: '2', count: 1
    assert_select 'tr>td', text: '3', count: 1
    assert_select 'tr>td', text: '8.88', count: 2
    assert_select 'tr>td', text: '9.99', count: 2
    assert_select 'tr>td', text: 'Name', count: 2
  end

  it 'shows an refresh link' do
    render
    assert_select 'a', text: 'Refresh', count: 1
  end

  context 'when the user clicks the refresh link' do
    before do
      render
      pending 'need to implement capybara'
      click_link 'Refresh'
    end

    it 'refreshes the stations' do
    end
  end
end
