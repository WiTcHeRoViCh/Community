# frozen_string_literal: true
class ProjectChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'project_channel_1'
	end

	def speak(data)
		proj = data['project']
		current_user = User.find(data['current_user'])

		project = current_user.projects.new(title: proj[0], photo: proj[1], description: proj[2], approved: 'false', crew: proj[3], user_code: proj[5])
		project.save!

		article = Article.new(title: proj[0], photo: proj[1], description: proj[2]+'\nDevelopers: '+proj[3], importance: 'Small', user_code: proj[5])
		article.save!

		channel_add_article(article)
	end

	def deleteProj(data)
		id = data['id']
		cur_user_code = data['cur_code']
		project = Project.find(id)
		projTitle = project.title
		current_user = {code: cur_user_code}

		project.delete
		article = Article.new(title: projTitle+" project was delete", photo: 'photo', description: "Reason", importance: 'Small', user_code: cur_user_code)
		article.save!

		channel_add_article(article)
	end

  def channel_add_article(article)
    ActionCable.server.broadcast(
      "project_channel_1",
      action: 'create',
      project: render_article(article)
    )
  end

  def render_article(project)
    ApplicationController.renderer.render(
      partial: 'projects/project',
      locals: { article: project, current_user: current_user }
    )
  end

end
