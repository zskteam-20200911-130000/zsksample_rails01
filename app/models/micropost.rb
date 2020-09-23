class Micropost < ApplicationRecord
  belongs_to :user, class_name: 'User', inverse_of: :microposts
  validates :content, length: { maximum: 140 }
end
