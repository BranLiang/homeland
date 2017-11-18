class AddScoreOnTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :weekly_score, :integer, default: 0, null: false
    add_column :topics, :daily_score, :integer, default: 0, null: false
  end
end
