# frozen_string_literal: true
class ArticleChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'article_channal_1'
	end

	def addArticle(data)
		article = data['article']
		if article['src'] != "" && article['name'] != ""
			photo = parse_image(article['src'], article['name']) 
		else
			photo = nil
		end

		title = article['title']
		description = article['description']
		importance = article['importance']
		user_code = article['user_code']

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

	def deleteArticle(data)
		article_id = data['article_id']
		article = Article.find(article_id)

		if article.delete
			ActionCable.server.broadcast(
				'article_channal_1',
				action: 'delete',
				article_id: article_id
			)
		else

		end
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
