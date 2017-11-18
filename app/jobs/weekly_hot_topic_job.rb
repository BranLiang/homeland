class WeeklyHotTopicJob
  include TimeRangeHelper
  include Sidekiq::Worker

  def perform
    clear_inactive_topics_score
    active_topics.each do |topic|
      topic.update_column(weekly_score: ScoreCalculator.new(topic, ranges).calculate)
    end
  end

  private

  def active_topics
    @topics = Topic
      .left_outer_joins(:topic_views)
      .where("topics.replied_at >= ? OR topic_views.created_at >= ?", week_age, week_age)
      .distinct
  end

  def clear_inactive_topics_score
    Topic.where.not(id: active_topics.pluck(:id)).update_all(weekly_score: 0)
  end

  def ranges
    @ranges ||= weekly_ranges(week_age)
  end

  def week_age
    @week_age ||= (Time.now - 6.days).beginning_of_day
  end
end
