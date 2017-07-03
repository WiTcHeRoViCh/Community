class ProfilesController < ApplicationController
	before_action :cur_prof, only: [:show]

	def show

	end	


	private

	def cur_prof
		@cur_prof = User.find(params[:id]).profile
	end
end	