class ProfilesController < ApplicationController
	before_action :user, only: [:show]
	load_and_authorize_resource

	def show

	end

	private

	def user
		@user = User.find(params[:id])
	end

	def user_photos
		@photos = User.find(params[:id]).photos.all.reverse
	end

	def user_articles
		@user_articles = Article.all.where(user_code: user.code)
	end

	def user_anon_message
		@anon_messages = user.anonymous_messages.reverse
	end



	helper_method :user_photos, :user, :user_articles, :user_anon_message
end

