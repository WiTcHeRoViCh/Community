class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => :create

	def new

	end

	def create
		user = User.find_by(code: params[:user][:code])

		if user && user.authenticate(params[:user][:password])
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