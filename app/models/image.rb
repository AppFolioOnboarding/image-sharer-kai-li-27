class Image < ApplicationRecord
    validates :url, presence: true, format: { with: /https?:\/\/[\S]+/ }
end