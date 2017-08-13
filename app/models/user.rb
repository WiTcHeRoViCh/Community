class User < ApplicationRecord
	after_create :create_profile

	has_secure_password

	has_one :profile
	has_many :projects
	has_many :photos
	has_many :anonymous_messages
end
