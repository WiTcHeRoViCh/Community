class MainsController < ApplicationController

	def index
		@users_profile = prof
	end	

	private

	def prof
		c = []
		users = User.all

		for user in users do 
			c.push(user.profile)
		end
		return c
	end
end
