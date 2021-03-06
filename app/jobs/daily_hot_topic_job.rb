class DailyHotTopicJob
  include TimeRangeHelper
  include Sidekiq::Worker

  def perform
    clear_inactive_topics_score
    active_topics.each do |topic|
      topic.update_column(:daily_score, ScoreCalculator.new(topic, ranges).calculate)
    end
  end

  private

  def active_topics
    @topics = Topic
      .left_outer_joins(:topic_views)
      .where("topics.replied_at >= ? OR topic_views.created_at >= ?", day_ago, day_ago)
      .distinct
  end

  def clear_inactive_topics_score
    Topic.where.not(id: active_topics.pluck(:id)).update_all(daily_score: 0)
  end

  def ranges
    @ranges ||= daily_ranges(day_ago)
  end

  def day_ago
    @day_ago ||= Time.now - 1.day
  end
end
