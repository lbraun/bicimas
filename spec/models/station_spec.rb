require 'rails_helper'

RSpec.describe Station, type: :model do
  describe '.pull_data' do
    it 'creates all the stations when they are not already there' do
      expect(Station.count).to eq(0)
      Station.pull_data
      expect(Station.count).to eq(57)
    end
  end
end
