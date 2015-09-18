class QuestionsController < ApplicationController

	def new
		@question = Question.new
	end

	def create

		if session[:user_id].nil?
			render 'login'
		else
			@question = Question.new(question_params)
			@user = User.find_by(id: session[:user_id])
			if @question.save
			   @user.questions << @question
			   redirect_to @question
			else 
				flash[:danger] = "Oops...something's not right bout your question lad"
				render 'new'
			end
		end

	end


	def index
	  @questions = Question.all
	end

	def show
      @question = Question.find(params[:id])
      session[:question_id] = params[:id]
      @user = @question.user
      @answer = Answer.new
      # unless @question.add_user_vote(session[:user_id])
      # 	return false
      # end
    end


private

    def question_params
      params.require(:question).permit(:title, :content)
    end

end
