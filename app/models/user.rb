class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	has_many :questions,:dependent => :destroy
	has_many :answers,:dependent => :destroy
	has_secure_password

	validates	:email, uniqueness: {message: "Email already existed"}
	validates	:valid_email?, numericality: {message: "Email address not valid"}
	validates	:valid_password?, numericality: {message: "Password must be at least 6 characters and include one number and one letter." }

	def answered_questions
		qtoa = []
		self.answers.each {|answer| qtoa << answer.question}
		qtoa
	end

	def valid_email?
		self.email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
	end

	def valid_password?
		self.password =~/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/
	end
end
