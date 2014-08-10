require 'spec_helper'

describe 'liking posts' do 
	before do 
		user = User.create(email: 'ollie@2.com', password: '12345678', password_confirmation: '12345678')
		login_as user
		Post.create(description: 'Comment test')
	end

	it 'increments the like count of a post' do
		visit '/posts'
		click_link "❤ 0"
		expect(page).to have_link '❤ 1'
	end
end