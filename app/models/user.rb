class User < ActiveRecord::Base
	has_secure_password
	has_many :questions
	has_many :answers
	has_many :votes
	has_many :comments


	validates :password, length: {minimum: 6}
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, length: {maximum: 255},
	                  format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: { case_sensitive: false }

end
