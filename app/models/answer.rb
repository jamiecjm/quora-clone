class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belongs_to :question
	belongs_to :user
	has_many :answervotes,:dependent => :destroy

	def self.topvoted
		answer = []
		count = [0]
		self.all.each do |a|
			inserted = false
			i = count.index(count.min)
			votecount = a.answervotes.where(vote_type: true).count
			count.each_with_index do |c,i|
				if votecount>c
					count.insert(i,votecount)
					answer.insert(i,a)
					inserted = true
					break
				end
			end
			
			if inserted == false
				count.push(votecount)
				answer.push(a)
			end
		end
		answer
	end
end
