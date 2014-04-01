# encoding: utf-8

class CustomerCenter::QuestionCommentsController < AnonCommentController
  before_action :set_question_comment, only: [:show, :edit, :update, :destroy]  
  
  def show
    @parent=@question_comment.question
    return @question_comment
  end
  
  def edit
    @question = @question_comment.question
    return @question_comment
  end
  
  def create
    @question = Question.find(params[:question_id])
    if current_user
      params[:question_comment][:user_id]=current_user.id
    end
    
    respond_to do |format|
      if Rails.env.production? 
        if current_user
          @question_comment=@question.guest_book_comment.create(question_comment_params)
        else
          @question_comment=verify_recaptcha(:model => @question, :message => "Oh! It's error with reCAPTCHA!") && @question_comment.guest_book_comment.create(question_comment_params)
        end
      else
        @question_comment=@question.guest_book_comment.create(question_comment_params)
      end
      
      if @question_comment
        format.html { redirect_to @question, :notice=> @controller_name +t(:message_success_create)}
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @question_comment.update_attributes(question_comment_params)
        format.html { redirect_to @question_comment.question, :notice=> @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @question_comment.errors, :status => :unprocessable_entity }
      end
    end
  end  
 
  def destroy
    @question_comment.destroy
    redirect_to question_path(@question_comment.question)
  end
  
  protected
  
  def get_gg 
    return set_question_comment
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question_comment
    @question_comment = QuestionComment.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def question_comment_params
    params.require(:question_comment).permit(:id,:user_id,:question_id,:name,:salt,:password,:content)
  end
end
