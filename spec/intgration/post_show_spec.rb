require 'rails_helper'

RSpec.describe 'Posts show page', type: :feature do
  before(:each) do
    User.destroy_all
    @user = User.create(name: 'Tufahel', photo: 'pic.png', bio: 'student',
                        email: 'tufahel97@email.com', password: '1234abc',
                        confirmed_at: Time.now, role: 'admin', posts_counter: 0)
    @user1 = User.create(name: 'Ahmed', photo: 'pic.jpg', bio: 'Businessmen', email: 'ahmed@email.com',
                         password: 'bcd1234', confirmed_at: Time.now)
    Post.create(title: 'Title', text: 'Text', user_id: @user.id, likes_counter: 0, comment_counter: 0)
    @comment = Comment.create(text: 'First comment', user: User.first, post: Post.first)
    @comment = Comment.create(text: 'Second comment', user: User.first, post: Post.first)
    @like = Like.create(user_id: User.first.id, post_id: Post.first.id)

    visit new_user_session_path
    fill_in 'Email', with: 'tufahel97@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit "/users/#{User.first.id}/posts/#{Post.first.id}"
  end

  describe 'Specs for view posts#show' do
    it 'I can see the posts title.' do
      expect(page).to have_content 'Title'
    end

    it 'I can see who wrote the post' do
      expect(page).to have_content 'Tufahel'
    end

    it 'I can see how many comments it has' do
      expect(page).to have_content 'Comments: 2'
    end

    it 'I can see how many likes it has' do
      expect(page).to have_content 'Likes: 1'
    end

    it 'I can see the post body' do
      expect(page).to have_content 'Text'
    end

    it 'I can see the username of each commentor' do
      expect(page).to have_content 'Tufahel'
    end

    it 'I can see the comment each commentor left' do
      expect(page).to have_content 'First comment'
      expect(page).to have_content 'Second comment'
    end
  end
end