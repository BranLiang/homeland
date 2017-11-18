require 'rails_helper'

describe DailyHotTopicJob do
  let(:topic) { create(:topic) }

  describe '#perform' do
    before(:each) do
      create(:reply, topic: topic)
    end

    it 'should change topic weekly_scores' do
      DailyHotTopicJob.new.perform
      expect(topic.reload.daily_score).to eq(72)
    end
  end
end
