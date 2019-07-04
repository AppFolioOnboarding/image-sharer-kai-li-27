class Image < ApplicationRecord
  validates :url, presence: true, format: { with: Regexp.union(%r{https?:\/\/[\S]+}, /data:image[\S]+/) }
end
