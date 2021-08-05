class Article < ApplicationRecord

  belongs_to :user
  has_many_attached :images
  has_many :comments
  has_many :likes
  has_many :like_users, through: :likes, source: :user

  with_options presence: true do 
    validates :store_name
    validates :text
  end

  geocoded_by :address
  before_validation :geocode
end
