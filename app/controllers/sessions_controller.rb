class SessionsController < ApplicationController

	def new
	end

	def create
	  user = User.find_by(email: params[:session][:email].downcase)

	  if user && user.authenticate(params[:session][:password])
	  	flash[:success] = "Welcome back 'ol chap"
		log_in(user)
		redirect_to(user)
	  end

	end

	def destroy
		log_out
		redirect_to root_url
	end

end
