class User < ApplicationRecord
	has_many :articles, -> { order(created_at: :desc) }, dependent: :destroy
	has_secure_password

	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :name,				 :presence 	=> true,
						:length										=> {:maximum => 50}
	validates :email,				 :presence	=> true,
						:format										=> {:with => email_regex},
						:uniqueness								=> {:case_sensitive => false}

end
