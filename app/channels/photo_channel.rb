# frozen_string_literal: true
class PhotoChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'photos_channel'
	end

	def addPhoto(data)
		if data['photo']['images'] != "undefined" && data['photo']['user_id'] != "undefined" && data['photo']['name'] != "undefined"
			images = parse_img(data['photo']['images'], data['photo']['name'])
			user_id = data['photo']['user_id']
		end

		if user_id
			user = User.find(user_id)
      article = Article.new(title: user.code+' add new photo', photo: images, user_code: user.code)
			photo = user.photos.new(images: images)
			clean_tempfile

      article.save!
			if photo.save!

				ActionCable.server.broadcast(
    			'photos_channel',
    			action: 'create',
    			photo: photo
    		)
    	else
				
    	end
    
    else

    end	

  end

  def deletePhoto(data)
  	cur_user = User.find(data["user_id"])
  	photo_id = data['photo_id']

  	photo = cur_user.photos.find(photo_id)

  	if photo.delete
			ActionCable.server.broadcast(
      	"photos_channel",
      	action: 'delete',
      	photo_id: photo_id
    	)
  	else

  	end

  end

  private

  def parse_img(base64_img, filename)
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
