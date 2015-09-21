class AnswersController < ApplicationController

	def create
		@user = User.find(session[:user_id])
		@question = Question.find(params[:answer][:question_id])

		@question.answers.create(text: params[:answer][:text], user: @user)

		redirect_to @question
	end

	def update
	  @question = Question.find(session[:question_id])
	  answer = Answer.find(params[:answer][:posted_answer_id])
      answer.update(best_answer: true)

      redirect_to @question
	end

end
