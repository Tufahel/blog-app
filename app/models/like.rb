class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_like_counter
    post.increment!(:posts_counter)
  end
end
