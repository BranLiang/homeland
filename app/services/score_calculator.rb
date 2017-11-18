class ScoreCalculator
  DEFAULT_REPLY_WEIGHT = 3

  def initialize(topic, ranges = [], options = {})
    @topic = topic
    @ranges = ranges
    @reply_weight = options[:reply_weight] || DEFAULT_REPLY_WEIGHT
  end

  def calculate
    ranges.each_with_index.inject(0) do |sum, (range, i)|
      sum + range_score(range, i + 1, @reply_weight)
    end
  end

  private

  attr_reader :topic, :ranges

  def range_score(range, time_weight, reply_weight)
    (views_count_between(range[0], range[1]) + replies_count_between(range[0], range[1]) * reply_weight) * time_weight
  end

  def views_count_between(start_time, end_time)
    topic.topic_views.where("created_at > ? AND created_at < ?", start_time, end_time).count
  end

  def replies_count_between(start_time, end_time)
    topic.replies.where("created_at > ? AND created_at < ?", start_time, end_time).count
  end
end
