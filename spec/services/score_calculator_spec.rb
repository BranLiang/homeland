require 'rails_helper'

describe ScoreCalculator do
  include TimeRangeHelper

  let(:topic) { create(:topic) }

  describe 'calculate' do
    context 'with no replies and no views' do
      it 'should return 0' do
        expect(ScoreCalculator.new(topic, weekly_ranges).calculate).to eq(0)
      end
    end

    context 'with 1 reply just now' do
      before(:each) do
        create(:reply, topic: topic)
      end

      it 'should return (0 + 1 * 3) * 7 = 21 for weekly score' do
        expect(ScoreCalculator.new(topic, weekly_ranges).calculate).to eq(21)
      end

      it 'should return (0 + 1 * 3) * 24 = 72 for daily score' do
        expect(ScoreCalculator.new(topic, daily_ranges).calculate).to eq(72)
      end
    end

    context 'with 1 reply and 1 view just now' do
      before(:each) do
        create(:reply, topic: topic)
        create(:topic_view, topic: topic)
      end

      it 'should return (1 + 1 * 3) * 7 = 28 for weekly score' do
        expect(ScoreCalculator.new(topic, weekly_ranges).calculate).to eq(28)
      end

      it 'should return (1 + 1 * 3) * 24 = 96 for daily score' do
        expect(ScoreCalculator.new(topic, daily_ranges).calculate).to eq(96)
      end
    end

    context 'with 1 reply just now, 1 replies 2 days ago' do
      before(:each) do
        create(:reply, topic: topic)
        2.times do
          create(:reply, topic: topic, created_at: Time.now - 2.days)
        end
      end

      it 'should return (1 * 3) * 7 + (2 * 3) * 5 = 51 for weekly score' do
        expect(ScoreCalculator.new(topic, weekly_ranges).calculate).to eq(51)
      end

      it 'should return (1 * 3) * 24 = 72 for daily score' do
        expect(ScoreCalculator.new(topic, daily_ranges).calculate).to eq(72)
      end
    end

    context 'with 1 reply just now, 2 replies 2.5 hours ago, 1 view just now, 1 view 2 days ago' do
      before(:each) do
        create(:reply, topic: topic)
        2.times do
          create(:reply, topic: topic, created_at: Time.now - 2.5.hours)
        end
        create(:topic_view, topic: topic)
        create(:topic_view, topic: topic, created_at: Time.now - 2.days)
      end

      it 'should return (1 + 3 * 3) * 7 + (1) * 5 = 75 for weekly score' do
        expect(ScoreCalculator.new(topic, weekly_ranges).calculate).to eq(75)
      end

      it 'should return (1 + 1 * 3) * 24 + (2 * 3) * 22 = 228 for daily score' do
        expect(ScoreCalculator.new(topic, daily_ranges).calculate).to eq(228)
      end
    end
  end
end
