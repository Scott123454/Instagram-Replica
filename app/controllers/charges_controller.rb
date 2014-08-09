class ChargesController < ApplicationController

	def new
		@post = Post.find params[:post_id]
	end

	def create
		@post = Post.find params[:post_id]
	  # Amount in cents
	    @amount = 500

	    customer = Stripe::Customer.create(
	        :email => params[:emailEmail],
	    	:card  => params[:stripeToken]
	    )

	    charge = Stripe::Charge.create(
	    	:customer    => customer.id,
	    	:amount      => @amount,
	    	:description => "Print of #{@post.description}",
	    	:currency    => 'usd'
	    )

	    Order.create(user: current_user, post: @post)

	rescue Stripe::CardError => e
	  	flash[:error] = e.message
	  	redirect_to post_charges_path(@post)
	end

end
