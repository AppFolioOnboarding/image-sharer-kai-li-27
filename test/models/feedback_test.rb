require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_save__name_and_comments_must_present
    feedback = Feedback.new(name: 'Kai', comments: 'awesome')

    assert_predicate feedback, :valid?
  end

  def test_save__missing_name_or_comments
    feedback = Feedback.new

    refute_predicate feedback, :valid?
    assert_equal feedback.errors.messages, name: ["can't be blank"], comments: ["can't be blank"]
  end
end
