class CommentsController < ApplicationController

	def new
	  @comment = Comment.new
	  @question = Question.find_by(id: session[:question_id])
	  respond_to do |format|
	  	format.html
	  	format.js
	  end
	end

	def show
	end

	def create
      if session[:user_id].nil?
			render 'login'
	    else
		  @question = Question.find_by(id: session[:question_id])
		  @user = User.find_by(id: session[:user_id])

		  respond_to do |format|
			if @question.comments.create(comment_params)
			   @question.comments.last.user = @user
	
			  format.html { redirect_to @question, notice: 'Woot, you posted a comment!' }
			  format.js
			else 
			  format.html {render :new}
			end
		  end
	    end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def comment_params
		params.require(:comment).permit(:text, :commentable_type, :commentable_id, :user_id)
	end

end
