require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_create__success
    assert_difference 'Feedback.count', 1 do
      post api_feedbacks_path, params: { feedback: { name: 'Kai', comments: 'awesome' } }
    end

    assert_response :ok

    res = JSON.parse(@response.body)
    assert_equal 'succeeded', res['message']
  end

  def test_create__fail_without_names_and_comments
    assert_no_difference 'Feedback.count' do
      post api_feedbacks_path, params: { feedback: { name: '', comments: '' } }
    end

    assert_response :unprocessable_entity

    res = JSON.parse(@response.body)
    assert_equal 'failed', res['message']
  end
end
