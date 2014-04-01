# encoding: utf-8

class CustomerCenter::QuestionsController < AnonBoardController
  include SecretBoard
  before_action :check_secret, :only => [:show]  
  before_action :set_question, :only=>[:show, :edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.question') 
  end
  
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.order('id desc').page(params[:page]).per(15)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @questions }
    end
  end
  
  # GET /questions/1
  # GET /questions/1.json
  def show
    @question_comments=@question.question_comment.order('id desc').page(params[:page]).per(10)
    @question_comment=QuestionComment.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @question }
    end
  end
  
  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    @question.build_question_content
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @question }
    end
  end
  
  # GET /questions/1/edit
  def edit
  end
  
  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    
    if current_user
      @question.user_id=current_user.id
    end 
    
    respond_to do |format|
      if Rails.env.production? 
        if current_user
          result=@question.save
        else
          result=verify_recaptcha(:model => @question, :message => "Oh! It's error with reCAPTCHA!") && @question.save
        end
      else
        result=@question.save
      end
      
      if result
        session[@question.class.name]||={} 
        session[@question.class.name][:guest_pass_id]||=[]
        session[@question.class.name][:guest_pass_id]<<@question.id
        format.html { redirect_to customer_center_question_url(@question), :notice=> @controller_name +t(:message_success_create)}
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /questions/1
  # PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update_attributes(question_params)
        format.html { redirect_to customer_center_question_url(@question), :notice=> @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    
    respond_to do |format|
      format.html { redirect_to customer_center_questions_url }
      format.json { head :ok }
    end
  end
  
  def get_gg 
    return set_question
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:id,:title,:name,:password,question_content_attributes: [:id,:content],question_answer_attributes: [:id,:content])
  end
end
