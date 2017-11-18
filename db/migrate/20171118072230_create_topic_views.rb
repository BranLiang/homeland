class CreateTopicViews < ActiveRecord::Migration[5.1]
  def change
    create_table :topic_views do |t|
      t.integer :topic_id

      t.timestamps
    end
    add_index :topic_views, :topic_id
  end
end
