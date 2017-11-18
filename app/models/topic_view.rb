class TopicView < ApplicationRecord
  belongs_to :topic, required: true
end
