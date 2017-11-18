require 'rails_helper'

RSpec.describe TopicView, type: :model do
  it 'should no save invalid topic_id' do
    expect(build(:topic_view, topic_id: nil).valid?).not_to be_truthy
  end
end
