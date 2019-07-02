require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'Should get images index page' do
    get images_path

    assert_response :ok
    assert_select 'h1', 'hello world'
    assert_select 'a' do
      assert_select '[href=?]', new_image_path
    end
  end
end
