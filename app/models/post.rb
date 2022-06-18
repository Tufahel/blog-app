class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presence: true, allow_blank: false, length: { maximum: 250 }
  validates :comment_counter, numericality: { only_integer: true, allow_nil: true }, comparison: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :likes_counter, numericality: { only_integer: true, allow_nil: true }, comparison: { greater_than_or_equal_to: 0, allow_nil: true }

  def update_post_counter
    user.increment!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
