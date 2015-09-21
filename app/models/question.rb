class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	has_many :votes, as: :votable
  has_many :comments, as: :commentable
	validates :title, :content, presence: true

  def add_user_vote(user)
    unless ( !!self.votes.find_by(user_id: user) == true )
      self.votes.create(user: user)
    else
      return false
    end
  end

  def total_answers
  	self.answers.size
  end

  def vote_count
  	size = self.votes.sum(:up) - self.votes.sum(:down)
  	size
  end

  def best_answer
    self.answers.find_by(best_answer: true)
  end

end
