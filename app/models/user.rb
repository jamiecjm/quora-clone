class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	has_many :questions,:dependent => :destroy
	has_many :answers,:dependent => :destroy
	has_many :questionvotes,:dependent => :destroy
	has_many :answervotes,:dependent => :destroy
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

	def upvoted_question?(q)
		voted = false
		self.questionvotes.each do |qv|
			if qv.question.id == q.id && qv.vote_type == true
				voted = true 
				break
			end
		end
		voted
	end

	def downvoted_question?(q)
		voted = false
		self.questionvotes.each do |qv|
			if qv.question.id == q.id && qv.vote_type == false
				voted = true 
				break
			end
		end
		voted
	end

	def upvoted_answer?(a)
		voted = false
		self.answervotes.each do |av|
			if av.answer.id == a.id && av.vote_type == true
				voted = true 
				break
			end
		end
		voted
	end

	def downvoted_answer?(a)
		voted = false
		self.answervotes.each do |av|
			if av.answer.id == a.id && av.vote_type == false
				voted = true 
				break
			end
		end
		voted
	end

end
