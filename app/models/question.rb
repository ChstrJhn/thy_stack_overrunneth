class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	has_many :votes, as: :votable
	validates :title, :content, presence: true

  def add_user_vote(user)
    if self.votes.include?(user)
      return false
    else
      self.votes.create(user: user)
      return true
    end
  end

  def total_answers
  	self.answers.size
  end

  def vote_count
  	self.votes.size
  end

end
