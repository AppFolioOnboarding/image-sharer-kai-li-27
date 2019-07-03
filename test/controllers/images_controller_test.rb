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

  test 'Should get images new action' do
    get new_image_path

    assert_response :ok
    assert_select 'form input[name="image[url]"]'
    assert_select 'form input[type=submit]'
  end

  test 'Should create a new image with valid input' do
    assert_difference('Image.count', 1) do
      post images_path, params: { image: { url: 'https://abc' } }
    end
    assert_redirected_to image_path(Image.last)
  end

  test 'Should not create a new image with invalid input' do
    assert_no_difference('Image.count') do
      post images_path, params: { image: { url: 'abcd' } }
    end
    assert_response :unprocessable_entity
    assert_select 'form input[name="image[url]"]'
  end

  test 'Should not create a new image with empty url' do
    assert_no_difference('Image.count') do
      post images_path, params: { image: { url: '' } }
    end
    assert_response :unprocessable_entity
    assert_select 'form input[name="image[url]"]'
  end
end
