class ProjectsController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => :create

	def create
		project = current_user.projects.new(project_params)
		project.save!

		article = Article.new(title: params[:project][:title], photo: params[:project][:photo], description: params[:project][:description]+"\nDevelopers: "+params[:project][:crew], importance: 'Small', user_code: params[:project][:user_code])
		article.save!

		channel_add_article(article)
	end

	private

	def project_params
		params.require(:project).permit(:title, :photo, :description, :user_code, :crew, :user_id, :approved)
	end

	def channel_add_article(article)
    ActionCable.server.broadcast(
      "article_channel_1",
      action: 'create',
      project: render_project(article)
    )
  end

  def render_project(project)
    ApplicationController.renderer.render(
      partial: 'projects/project',
      locals: { article: project, current_user: current_user }
    )
  end


end