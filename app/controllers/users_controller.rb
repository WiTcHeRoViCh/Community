class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => :create

	def index
		@users = User.all
	end


end
