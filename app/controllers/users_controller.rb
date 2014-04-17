# encoding: utf-8

class UsersController < BoardController
  before_filter :authenticate_user!, :except=>[:new,:edit,:user_id_select,:user_id_select_search_result]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_authorization_check :only => [:user_id_select, :user_id_select_search_result]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.user')
  end
  
  def user_id_select
    @script='users/user_id_select'
  end
  
  def user_id_select_search_result
    case params[:find_method]
      when 'login_id'
        condition_sql='login_id like ?'
      when 'name'
        condition_sql='name like ?'
      when 'user_id'
        condition_sql='id like ?'
      when 'market'
        condition_sql='market like ?'
    end
    
    unless params[:per_page].present?
      params[:per_page]=20
    end
    
    @user_count = User.order('id desc').where(condition_sql,'%'+params[:search].strip+'%').count    
    @users = User.order('id desc').where(condition_sql,'%'+params[:search].strip+'%').page(params[:page]).per(params[:per_page])

    @script='users/user_id_select'
    
    if(@user_count.zero?)
      a={:count=>@user_count}
    else
      a={:count=>@user_count,:list=>@users}
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => a }
    end        
  end 
  
  # GET /notices
  # GET /notices.json
  def index
    if current_user.role? :administrator      
      @users = User.order('id desc').page(params[:page]).per(15)
      a_template='users/index_admin' 
    elsif current_user.role? :operator
      @users = User.order('id desc').page(params[:page]).per(15)
      a_template='users/index_admin'
    elsif current_user.role? :sub_operator
      @users = User.where.not(:grade_id=>nil).where(:grade_id=>current_user.grade_id).order('id desc').page(params[:page]).per(15)
      a_template='users/index_admin'
    else
      @users = User.order('id desc').page(params[:page]).per(15)  
      a_template='users/index'
    end

    respond_to do |format|
      format.html {render a_template}
      format.json { render json: @attendances }
    end
  end
  
  def edit 
  
  end
  
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /notices/1
  # GET /notices/1.json
  def show    
    @family=Family.new
    @user_recommends=UserReferral.where(:recommend_user_id=>@user).order('recommend_user_id desc').page(params[:page]).per(10)
    @user_referral=@user.user_referral
    
    @script="users/new"          
  end
  
  def destroy 
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :birthday, :password, :password_confirmation, :current_password, :photo, :photo_cache)
  end
end