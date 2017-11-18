module TimeRangeHelper
  def weekly_ranges
    start_time = (Time.now - 6.days).beginning_of_day
    [].tap do |collection|
      7.times { collection << [start_time, start_time += 1.day] }
    end
  end

  def daily_ranges
    start_time = Time.now - 24.hours
    [].tap do |collection|
      24.times { collection << [start_time, start_time += 1.hour] }
    end
  end
end
