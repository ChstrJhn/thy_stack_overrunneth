class QuestionsController < ApplicationController

	def new
		@question = Question.new
	end

	def create

		if session[:user_id].nil?
			redirect_to login_path
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

	def upvote
	  if session[:user_id].nil?
	  	flash[:danger] = "You must login before you can vote"

	    redirect_to login_path
	  else
		@question = Question.find(session[:question_id])
		@user = User.find_by(id: session[:user_id])

		if @question.add_user_vote(@user)
          @question.votes.last.update(up: 1)
          flash[:success] = "You found this question useful, awesome!"

		  redirect_to @question
		else
		  flash[:danger] = "You've already voted!"

		  redirect_to @question
		end
	  end
	end

	def downvote
      if session[:user_id].nil?
	  	flash[:danger] = "You must login before you can vote"

	    redirect_to login_path
	  else
		@question = Question.find(session[:question_id])
		@user = User.find_by(id: session[:user_id])

		if @question.add_user_vote(@user)
          @question.votes.last.update(down: 1)
          flash[:success] = "Naw, maybe this question can be improved?"

		  redirect_to @question
	    else
	      flash[:danger] = "You've already voted!"

		  redirect_to @question
		end
	  end
	end

	def index
	  @questions = Question.all
	end

	def show
      @question = Question.find(params[:id])
      @no_best_answer = !@question.answers.find_by(best_answer:true)
      @question.views += 1
      @question.save!
      @best_answer = @question.best_answer
      session[:question_id] = params[:id]
      @user = @question.user
      @answer = Answer.new
      @comment = Comment.new
    end


private

    def question_params
      params.require(:question).permit(:title, :content)
    end

end
