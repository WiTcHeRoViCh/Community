class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => :create

	def index
		@users = User.all
	end

	def create
		binding.pry
		user = User.new(user_params)

		if user.save
			redirect_to :back
		else
			render :new
		end		
	end


	private

	def user_params
		params.require(:user).permit(:code, :password, :password_confirmation)
	end
end
