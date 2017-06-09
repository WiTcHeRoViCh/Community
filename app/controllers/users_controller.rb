class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => :create

	def index
		@users = User.all
	end

	def create
		@user = User.new(user_params)

		if @user.save
			render json: {"redirect":true,"redirect_url": root_path}, status:200
		else
			render json: @user.errors, status: :unprocessable_entity
			render :new
		end		
	end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :age, :post)
	end

end
