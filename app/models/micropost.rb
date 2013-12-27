
class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    # followed_user_ids = user.followed_user_ids
    # we don't need to pull out all of followed users into memory.
    followed_user_ids = "select followed_id from relationships where follower_id = :user_id"
    where("user_id in (#{followed_user_ids}) or user_id = :user_id", user_id: user)
  end
end
