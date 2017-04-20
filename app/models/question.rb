class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	has_many :answers,:dependent => :destroy
	has_many :questionvotes,:dependent => :destroy
	belongs_to :user

	def respondent
		user = []
		self.answers.each {|answer| user << answer.user}
		user
	end

	def self.topvoted
		question = []
		count = [0]
		self.all.each do |q|
			inserted = false
			i = count.index(count.min)
			votecount = q.questionvotes.where(vote_type: true).count
			count.each_with_index do |c,i|
				if votecount>c
					count.insert(i,votecount)
					question.insert(i,q)
					inserted = true
					break
				end
			end
			
			if inserted == false
				count.push(votecount)
				question.push(q)
			end
		end
		question
	end
end
