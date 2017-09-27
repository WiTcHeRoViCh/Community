# frozen_string_literal: true
class ProjectChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'project_channel_1'
	end

	def speak(data)
		proj = data['project']
		title = proj['title']
		description = proj['description']
		crew = proj['crew']
		user_code = proj['user_code']
		filename = proj['filename']
		image_url = proj['image_url']

		if filename != "" && image_url != ""
			photo = parse_image(image_url, filename) 
		else
			photo = nil
		end

		current_user = User.find(data['current_user'])

		project = current_user.projects.new(title: title, photo: photo, description: description, approved: 'false', crew: crew, user_code: user_code)
		project.save!

		article = Article.new(title: title, photo: photo, description: description+' Developers: '+crew, importance: 'Small', user_code: user_code)
		article.save!

		clean_tempfile

    ActionCable.server.broadcast(
      "project_channel_1",
      action: 'create',
      project: project,
      article: render_article(article)
    )

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

		channel_add_article(article, 'destroy')
	end


	private

  def channel_add_article(article, action)
    ActionCable.server.broadcast(
      "project_channel_1",
      action: action,
      project: render_article(article)
    )
  end

  def render_article(article)
    ApplicationController.renderer.render(
      partial: 'projects/project',
      locals: { article: article, current_user: current_user }
    )
  end

	def parse_image(base64_img, filename)
		in_content_type, encoding, string = base64_img.split(/[:;,]/)[1..3]
    content_type = filename.match(/.gif|.jpeg|.png|.jpg/).to_s
    filename = filename.chomp(content_type)

   	@tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
		@tempfile.rewind

		filename += "#{content_type}" if content_type

		ActionDispatch::Http::UploadedFile.new({
    	tempfile: @tempfile,
    	content_type: content_type,
    	filename: filename
		})
	end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
	end

end
