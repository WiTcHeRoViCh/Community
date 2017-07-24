# frozen_string_literal: true
class ProjectChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'project_channal_1'
	end

	def speak(data)
		proj = data['project']
		current_user = User.find(data['current_user'])

		project = current_user.projects.new(title: proj[0], photo: proj[1], description: proj[2], approved: 'false', crew: proj[3], user_code: proj[5])
		project.save!

		article = Article.new(title: proj[0], photo: proj[1], description: proj[2]+"\nDevelopers: "+proj[3], importance: 'Small', user_code: proj[5])
		article.save!

		channel_add_article(article)
	end

	def channel_add_article(article)
    ActionCable.server.broadcast(
      "project_channal_1",
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
