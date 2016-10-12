class SessionsController < ApplicationController
	def new
		if signed_in?
			redirect_to user_articles_path(current_user)
		end
	end

	def create
	  user = User.authenticate(params[:session][:email], params[:session][:password])
		if user.nil?
			flash.now[:error] = "Invalid email/password combination."
			render :action => 'new'
		else
			sign_in user
			redirect_to user_articles_path(user)
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
