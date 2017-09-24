class User < ApplicationRecord
	after_create :create_profile

	has_secure_password

	has_one :profile
	has_many :projects
	has_many :photos
	has_many :anonymous_messages
 	has_and_belongs_to_many :conversations
end
