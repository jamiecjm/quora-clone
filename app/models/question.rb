class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	has_many :answers,:dependent => :destroy
	belongs_to :user

	def respondent
		user = []
		self.answers.each {|answer| user << answer.user}
		user
	end

end
