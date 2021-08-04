class Article < ApplicationRecord
  
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_many :likes
  has_many :like_users, through: :likes, source: :user

  with_options presence: true do 
    validates :store_name
    validates :text
  end
end
