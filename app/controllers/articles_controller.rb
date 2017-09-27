class ArticlesController < ApplicationController

	def destroy
		article = Article.find(params[:id])
		article.delete

		redirect_to root_path
	end	

end