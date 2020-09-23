class User < ApplicationRecord
  has_many   :microposts, class_name: 'Micropost', dependent: :destroy, inverse_of: :user
  validates :name, presence: true
  validates :email, presence: true
end
