require 'spec_helper'

describe 'orders page' do
	user = User.create(email: 'ollie@ollie.com', password: '12345678', password_confirmation: '12345678')
	admin = Admin.create(email: 'ollie@ollie.com', password: '12345678', password_confirmation: '12345678')
	Post.create(description: 'Admin test')


	context 'logged in as admin' do
		before do
			login_as admin scope: :admin
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

	end

	# before do
	# 	Order.create()
	# end
end