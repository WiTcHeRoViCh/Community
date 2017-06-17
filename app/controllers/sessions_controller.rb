class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(code: params[:code], password: params[:password])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:error] = "No one user with this password or code!"
			redirect_to :back
		end	
		
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

end