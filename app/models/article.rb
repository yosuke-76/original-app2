class Article < ApplicationRecord

  belongs_to :user
  has_many_attached :images
  has_many :comments
  has_many :likes
  has_many :like_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy

  with_options presence: true do 
    validates :store_name
    validates :text
  end

  geocoded_by :address
  before_validation :geocode

  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      article_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end