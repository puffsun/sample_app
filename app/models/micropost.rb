
class Micropost < ActiveRecord::Base

  REPLY_TO_REGEX = /.*@([^\s]*)/

  attr_accessible :content, :in_reply_to
  belongs_to :user
  belongs_to :in_reply_to, class_name: "User"

  before_save :extract_in_reply_to

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope order: 'microposts.created_at DESC'

  #scope :from_users_followed_by, lambda { |u| followed_by(u) }
  scope :from_users_followed_by_including_replies, lambda { |u| followed_by_including_replies(u) }

  private

  def self.followed_by_including_replies(user)
    # followed_user_ids = user.followed_user_ids
    # we don't need to pull out all of followed users into memory.
    followed_user_ids = "select followed_id from relationships where follower_id = :user_id"
    where("user_id in (#{followed_user_ids}) or user_id = :user_id or in_reply_to_id = :user_id", user_id: user)
  end

  def extract_in_reply_to
    if match = REPLY_TO_REGEX.match(content)
      user = User.find_by_nickname(match[1])
      self.in_reply_to = user if user
    end
  end
end
