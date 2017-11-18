require 'rails_helper'

describe TimeRangeHelper, type: :helper do
  describe 'weekly_ranges' do
    it 'return 7 day ranges' do
      expect(helper.weekly_ranges.length).to eq(7)
    end
  end

  describe 'daily_ranges' do
    it 'return 24 hour ranges' do
      expect(helper.daily_ranges.length).to eq(24)
    end
  end
end
