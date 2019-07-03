require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'Should not save image without url' do
    image = Image.new

    assert_not_predicate image, :valid?
  end

  test 'Should not save image with bad url' do
    image = Image.new(url: 'asdfasd')

    assert_not_predicate image, :valid?
  end

  test 'Should save with valid https url' do
    image = Image.new(url: 'https://asae')

    assert_predicate image, :valid?
  end

  test 'Should save with valid http url' do
    image = Image.new(url: 'http://asdf')

    assert_predicate image, :valid?
  end
end
