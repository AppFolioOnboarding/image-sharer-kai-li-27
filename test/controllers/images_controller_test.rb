require 'test_helper'

# rubocop :disable Metrics/ClassLength
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
    assert_select 'label.badge', 0
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

  def test_show_has_tag
    image = Image.create!(url: 'https://a', tag_list: 'tag')

    get image_path(image)

    assert_response :ok
    assert_select 'label.badge', count: 1, text: 'tag'
  end

  def test_index_has_tags
    Image.create!(url: 'https://a', tag_list: 'tag1')
    Image.create!(url: 'https://b', tag_list: 'tag2')
    Image.create!(url: 'https://c')

    get images_path

    assert_response :ok
    assert_select "img[src='https://a'] ~ label.badge > a[href='#{images_path(tag: 'tag1')}']",
                  count: 1,
                  text: 'tag1'
    assert_select "img[src='https://b'] ~ label.badge > a[href='#{images_path(tag: 'tag2')}']",
                  count: 1,
                  text: 'tag2'
    assert_select 'img[src="https://c"]'
    assert_select 'img[src="https://c"] ~ label.badge', 0
  end

  def test_index_filter_by_tags
    Image.create!(url: 'https://a', tag_list: 'tag1')
    Image.create!(url: 'https://b', tag_list: 'tag2')
    Image.create!(url: 'https://c')

    get images_path(tag: 'tag1')

    assert_response :ok
    assert_select 'img[src="https://a"]'
    assert_select 'img', 1
  end

  def test_delete_image
    image = Image.create!(url: 'https://a', tag_list: 'tag1')

    assert_difference 'Image.count', -1 do
      delete image_path(image)
    end

    assert_redirected_to images_path
    assert_nil Image.find_by(id: image.id)
  end

  def test_delete_image_not_found
    assert_no_difference 'Image.count' do
      delete image_path(1)
    end

    assert_redirected_to images_path

    get images_path
    assert_select '#flashError', 1
  end

  def test_index_has_delete_button
    image = Image.create!(url: 'https://a', tag_list: 'tag1')

    get images_path

    assert_select "a[href='#{image_path(image)}'][data-method=delete]"
  end
end
# rubocop :enable Metrics/ClassLength
