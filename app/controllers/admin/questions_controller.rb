# encoding: utf-8

class Admin::QuestionsController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='수정이에게 질문'
  end  
  
  # GET /admin/questions
  # GET /admin/questions.json
  def index
    @admin_questions = Question.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_questions }
    end
  end
  
  # GET /admin/questions/1
  # GET /admin/questions/1.json
  def show
    @admin_question = Question.find(params[:id])
    @admin_question_answers=@admin_question.question_answer.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_question }
    end
  end
  
  # GET /admin/questions/new
  # GET /admin/questions/new.json
  def new
    @admin_question = Question.new
    @admin_question.build_question_content
    @script="board/new"
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @admin_question }
    end
  end
  
  # GET /admin/questions/1/edit
  def edit
    @admin_question = Question.find(params[:id])
  end
  
  # POST /admin/questions
  # POST /admin/questions.json
  def create
    @admin_question = Question.new(params[:question])
    
    if current_user
      @admin_question.user_id=current_user.id
    end 
    
    respond_to do |format|
      if @admin_question.save
        session[@admin_question.class.name]||={} 
        session[@admin_question.class.name][:guest_pass_id]||=[]
        session[@admin_question.class.name][:guest_pass_id]<<@admin_question.id
        format.html { redirect_to @admin_question, :notice => '질문이 작성되었습니다.' }
        format.json { render :json => @admin_question, :status => :created, :location => @admin_question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @admin_question.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /admin/questions/1
  # PUT /admin/questions/1.json
  def update
    @admin_question = Question.find(params[:id])
    
    respond_to do |format|
      if @admin_question.update_attributes(params[:question])
        format.html { redirect_to @admin_question, :notice => '질문이 수정되었습니다.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_question.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admin/questions/1
  # DELETE /admin/questions/1.json
  def destroy
    @admin_question = Question.find(params[:id])
    @admin_question.destroy
    
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :ok }
    end
  end
  
  def read_password_fail
    
  end
  
  def read_password
    self._read_password
  end
  
  def read_privileges?
    self._read_privileges
  end
  
  protected
  
  def _read_privileges
    gg=self.edit
    @gname=gg.class.name 
    @gid=gg.id
    
    unless gg.secret?
      return true
    end
    
    if(gg.user_id)
      if(current_user)
        if(current_user.id===gg.user_id)
          return true
        else
          return false
        end
      else
        return false
      end
    end
    
    unless session.key?(@gname)
      return false
    else
      if session[@gname][:guest_pass_id]
        unless session[@gname][:guest_pass_id].include?(@gid)
          return false
        end
      else
        return false
      end
    end
    
    return true
  end
  
  def _read_password
    gg=self.edit
    @gid=gg.id
    @gname=gg.class.name
    
    session[@gname]||={}    
    session[@gname][:guest_pass_id]||=[]
    
    if session[@gname][:guest_pass_fail]
      if session[@gname][:guest_pass_fail].key?(@gid)
        if session[@gname][:guest_pass_fail][@gid].to_i>3
          render(:action=>'read_password_fail',:id=>@gid)
        end
      else
        session[@gname][:guest_pass_fail][@gid]=0
      end
    else
      session[@gname][:guest_pass_fail]={}
      session[@gname][:guest_pass_fail][@gid]=0
    end
    
    if(params[:password])
      if params[:password]==gg.password
        session[@gname][:guest_pass_id]<<@gid
        redirect_to(:action=>'show',:id=>@gid)
      else
        session[@gname][:guest_pass_fail][@gid]=session[@gname][:guest_pass_fail][@gid].to_i+1
        flash.now[:notice]='비밀번호가 일치하지 않습니다.'
      end
    else
      flash.now[:notice]='비밀번호를 입력해주세요.'
    end
  end
  
  def check_secret
    if self.read_privileges?
      return true
    end
    
    redirect_to(:action=>'read_password',:id=>@gid)
  end
end
