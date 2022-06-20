require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Spec for like model' do
    before(:each) do
      @user = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.',
                       posts_counter: 0)
      @post = Post.new(user: @user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comment_counter: 0)
      @like = Like.new(user_id: 3, post_id: 1)
    end

    it 'User id must not blank' do
      @like.user_id = nil
      expect(@like).to_not be_valid
    end

    it 'Post id must not blank' do
      @like.post_id = nil
      expect(@like).to_not be_valid
    end
  end
end
