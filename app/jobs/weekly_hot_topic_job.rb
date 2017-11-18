class WeeklyHotTopicJob
  include TimeRangeHelper
  include Sidekiq::Worker

  def perform
    target_topics.each do |topic|
      ScoreCalculator.new(topic, ranges).calculate
    end
  end

  private

  def target_topics
    Topic
      .left_outer_joins(:topic_views)
      .where("topics.replied_at >= ? OR topic_views.created_at >= ?", Time.now - 1.week, Time.now - 1.week)
      .distinct
  end

  def ranges
    @ranges ||= weekly_ranges
  end
end
