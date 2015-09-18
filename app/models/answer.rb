class Answer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	has_many :votes, as: :votable

	def best_answer?
	  return false unless self.best_answer == true
	end

end
