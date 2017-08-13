class Photo < ApplicationRecord
	belongs_to :user

	mount_base64_uploader :images, ImageUploader
end
