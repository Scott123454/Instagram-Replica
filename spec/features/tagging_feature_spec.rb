require 'spec_helper'

describe 'tagging posts' do
	before do
		ollie = User.create(email: 'ollie@9.com', password: '12345678', password_confirmation: '12345678')
		login_as ollie
	end

	it 'displays the tags on the posts page' do
		visit '/posts'
		fill_in 'Description', with: 'My new post'
		path = Rails.root.join("app/assets/posts/image.jpeg")
		attach_file('Picture', path)
		fill_in 'Tags', with: 'lol, spiffing'
		click_button 'Upload'
		expect(page).to have_link '#lol'
		expect(page).to have_link '#spiffing'
	end

	describe 'filter post by tag' do
		before do
			Post.create(description: 'tag test1', tag_names: 'yolo')
			Post.create(description: 'tag test2', tag_names: 'swag')
			visit '/posts'
		end

		it 'uses the tag name in the url' do
			click_link '#yolo'
			expect(current_path).to eq '/tags/yolo'
		end

		it 'only shows posts with the selected tag' do
			click_link '#yolo'
			expect(page).to have_css 'h1', text: 'Posts tagged with #yolo'
			expect(page).to have_content 'tag test1'
			expect(page).not_to have_content 'tag test2'
		end
	end

end