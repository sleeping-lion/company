# encoding: utf-8

class Admin::TemplatesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='공지사항'
  end
 
  # GET /admin/templates
  # GET /admin/templates.json
  def index
    @admin_templates = Template.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_templates }
    end
  end

  # GET /admin/templates/1
  # GET /admin/templates/1.json
  def show
    @admin_template = Template.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_template }
    end
  end

  # GET /admin/templates/new
  # GET /admin/templates/new.json
  def new
    @admin_template = Template.new
    @admin_template.build_template_content
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_template }
    end
  end

  # GET /templates/1/edit
  def edit
    @admin_template = Template.find(params[:id])
  end

  # POST /admin/templates
  # POST /admin/templates.json
  def create
    @admin_template = Template.new(params[:notice])
    @admin_template.user_id=current_user.id

    respond_to do |format|
      if @admin_template.save
        format.html { redirect_to admin_templates_url, notice: '공지사항이 작성되었습니다.' }
        format.json { render json: @admin_template, status: :created, location: @admin_template }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/templates/1
  # PUT /admin/templates/1.json
  def update
    @admin_template = Template.find(params[:id])

    respond_to do |format|
      if @admin_template.update_attributes(params[:notice])
        format.html { redirect_to admin_templates_url, notice: '공지사항이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/templates/1
  # DELETE /admin/templates/1.json
  def destroy
    @admin_template = Template.find(params[:id])
    @admin_template.destroy

    respond_to do |format|
      format.html { redirect_to admin_templates_url }
      format.json { head :no_content }
    end
  end
end
