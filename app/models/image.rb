class Image < ApplicationRecord
  validates :url, presence: true, format: { with: %r{https?:\/\/[\S]+} }
end
