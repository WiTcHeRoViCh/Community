# frozen_string_literal: true
class ArticleChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'article_channal_1'
	end

	def addArticle(data)
		photo = parse_image(data['article']['src'], data['article']['name'])
		article = data['article']
		title = article['state']['title']
		description = article['state']['description']
		importance = article['state']['importance']
		user_code = article['state']['user_code']

		new_article = Article.new(title: title, photo: photo, description: description, importance: importance, user_code: user_code)
		clean_tempfile

		if new_article.save!

			ActionCable.server.broadcast(
    		'article_channal_1',
    		action: 'create',
    		article: new_article
    	)
    else
				
    end
	end

	def delete(data)
		article = Article.find(data['id'])
		article.delete
	end

	private

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
