# encoding: utf-8

class Admin::NoticesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='공지사항'
  end
 
  # GET /admin/notices
  # GET /admin/notices.json
  def index
    @admin_notices = Notice.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_notices }
    end
  end

  # GET /admin/notices/1
  # GET /admin/notices/1.json
  def show
    @admin_notice = Notice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_notice }
    end
  end

  # GET /admin/notices/new
  # GET /admin/notices/new.json
  def new
    @admin_notice = Notice.new
    @admin_notice.build_notice_content
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_notice }
    end
  end

  # GET /notices/1/edit
  def edit
    @admin_notice = Notice.find(params[:id])
  end

  # POST /admin/notices
  # POST /admin/notices.json
  def create
    @admin_notice = Notice.new(params[:notice])
    @admin_notice.user_id=current_user.id

    respond_to do |format|
      if @admin_notice.save
        format.html { redirect_to admin_notices_url, notice: '공지사항이 작성되었습니다.' }
        format.json { render json: @admin_notice, status: :created, location: @admin_notice }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/notices/1
  # PUT /admin/notices/1.json
  def update
    @admin_notice = Notice.find(params[:id])

    respond_to do |format|
      if @admin_notice.update_attributes(params[:notice])
        format.html { redirect_to admin_notices_url, notice: '공지사항이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/notices/1
  # DELETE /admin/notices/1.json
  def destroy
    @admin_notice = Notice.find(params[:id])
    @admin_notice.destroy

    respond_to do |format|
      format.html { redirect_to admin_notices_url }
      format.json { head :no_content }
    end
  end
end
