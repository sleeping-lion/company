# encoding: utf-8

class CustomerCenter::NoticesController < BoardController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:index,:show]

  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.notice')
  end
  
  # GET /notices
  # GET /notices.json
  def index
    @notices = Notice.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notices }
    end
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notice }
    end
  end

  # GET /notices/new
  # GET /notices/new.json
  def new
    @notice = Notice.new
    @notice.build_notice_content
    @script='board/new'    
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notice }
    end
  end

  # GET /notices/1/edit
  def edit
    @script='board/edit'    
  end

  # POST /notices
  # POST /notices.json
  def create
    @notice = Notice.new(notice_params)
    @notice.user_id=current_user.id

    respond_to do |format|
      if @notice.save
        format.html { redirect_to customer_center_notice_url(@notice), :notice=> @controller_name +t(:message_success_update)}
        format.json { render json: @notice, status: :created, location: @notice }
      else
        format.html { render action: "new" }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notices/1
  # PUT /notices/1.json
  def update
    respond_to do |format|
      if @notice.update_attributes(notice_params)
        format.html { redirect_to customer_center_notice_url(@notice), :notice=> @controller_name +t(:message_success_create)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    @notice.destroy

    respond_to do |format|
      format.html { redirect_to customer_center_notices_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_notice
    @notice = Notice.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def notice_params
    params.require(:notice).permit(:id,:title,notice_content_attributes: [:id,:content])
  end
end
