require 'rails_helper'

describe WeeklyHotTopicJob do
  let(:topic) { create(:topic) }

  describe '#perform' do
    before(:each) do
      create(:reply, topic: topic)
    end

    it 'should change topic weekly_scores' do
      WeeklyHotTopicJob.new.perform
      expect(topic.reload.weekly_score).to eq(21)
    end
  end
end
