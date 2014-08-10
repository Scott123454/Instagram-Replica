require 'spec_helper'

describe 'orders' do
	user = User.create(email: 'ollie@3.com', password: '12345678', password_confirmation: '12345678')
	admin = Admin.create(email: 'scott@scott.com', password: '12345678', password_confirmation: '12345678')
	post = Post.create(description: 'Pretty picture')
	
	describe 'orders page' do

		context 'logged in as admin' do
			before do
				login_as admin, scope: :admin
			end

			context 'no orders' do
				it 'see a message' do
					visit '/orders'
					expect(page).to have_content 'No orders yet'
				end
			end
		end

		context 'not logged in as an admin' do
			it 'prompts to sign in' do
				visit '/orders'
				expect(page).to have_content 'sign up'
			end
		end

		context 'with orders' do
			before do
				login_as admin, scope: :admin
				christmas_day = Date.new(2013, 12, 25)
				Order.create(id: 1, post: post, user: user, created_at: christmas_day)
				visit '/orders'		
			end
		

			it 'displays the product' do
			 	expect(page).to have_link 'Pretty picture'
			end

			it 'displays the customer email' do
				expect(page).to have_content 'customer@blah.com'
			end

			it 'displays an order number' do
				expect(page).to have content '2512130001'
			end

		end

		describe 'order email' do
			before do
				clear_emails
			end

			it 'sends an email with an order number and name of picture' do
				Order.create(user: user, post: post)
				open_email('ollie@3.com')
				expect(current_email).to have_content 'Pretty picture'
			end
		end
	end
end