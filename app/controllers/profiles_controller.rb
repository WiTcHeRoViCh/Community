class ProfilesController < ApplicationController
	before_action :user, only: [:show, :edit]
	load_and_authorize_resource

	def show
		@report = Report.new
	end

	def edit
		@profile = current_user.profile
	end

	def update
		@profile.update(profile_params)
		redirect_to edit_user_profile_path(current_user, @profile)
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

	def profile_params
		params.require(:profile).permit(:name, :surname, :avatar, :age, :birthday, :country, :where_want_to_live, :place_of_study, :hobby, :favorite_music, :plan_for_future, :description, :association_with_animal, :hide_news, :hide_photos, :hide_user_inf, :hide_anon_input, :can_write, :hide_all)
	end


	helper_method :user_photos, :user, :user_articles, :user_anon_message
end

