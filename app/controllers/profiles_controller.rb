class ProfilesController < ApplicationController
	before_action :user, only: [:show]
	load_and_authorize_resource

	def show

	end	


	private

	def user
		@user = User.find(params[:id])
	end
end	