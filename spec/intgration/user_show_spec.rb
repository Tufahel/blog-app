require 'rails_helper'

RSpec.feature 'Testing user show page', type: :feature do
  before(:each) do
    User.destroy_all
    @first = User.create(name: 'Tufahel', photo: 'pic.png',
                         bio: 'Developer', email: 'tufahel@gmail.com', password: '1234abcd',
                         confirmed_at: Time.now, role: 'admin', posts_counter: 0)

    visit user_session_path

    within 'form' do
      fill_in 'Email', with: @first.email
      fill_in 'Password', with: @first.password
    end

    click_button 'Log in'
  end

  background { visit user_path(User.first.id) }

  scenario "I can see the user's username" do
    expect(page).to have_content('Tufahel')
  end

  scenario "I can see the user's profile picture" do
    expect(page.first('img')['src']).to have_content 'pic.png'
  end

  scenario "I can see the user's bio" do
    expect(page).to have_content('Developer')
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    click_link('See all posts')
    expect(current_path).to eq user_posts_path(User.first.id)
  end
end
