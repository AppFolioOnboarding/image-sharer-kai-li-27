require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'Should get images index page' do
    get images_path

    assert_response :ok
    assert_select 'a' do
      assert_select '[href=?]', new_image_path
    end
  end

  test 'Should get images new action' do
    get new_image_path

    assert_response :ok
    assert_select 'form input[name="image[url]"]'
    assert_select 'input[name="image[tag_list]"]', 1
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

  test 'Should dipslay correct image' do
    image = Image.create!(url: 'https://asasdf')

    get image_path(image)

    assert_response :ok
    assert_select 'img'
  end

  def test_index_show_images_in_reverse_chronological_order
    Image.create!(url: 'https://1')
    Image.create!(url: 'https://2')

    get images_path

    assert_response :ok
    assert_select 'img' do |elements|
      assert_equal 'https://2', elements.first[:src]
      assert_equal 'https://1', elements.last[:src]
    end
  end
end
