class Article < ApplicationRecord
  
  belongs_to :user
  has_one_attached :image

  with_options presence: true do 
    validates :store_name
    validates :text
  end
end
