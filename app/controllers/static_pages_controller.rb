class StaticPagesController < ApplicationController

  def home
  	@questions = Question.all
  	@users = User.all
  end

end

