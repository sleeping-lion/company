# encoding: utf-8

class Admin::TemplateSourcesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='Template Sources'
  end
 
  # GET /admin/templates
  # GET /admin/templates.json
  def index
    @admin_template_sources = TemplateSource.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_template_source_types }
    end
  end

  # GET /admin/templates/1
  # GET /admin/templates/1.json
  def show
    @admin_template_source = TemplateSource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_template_source }
    end
  end

  # GET /admin/templates/new
  # GET /admin/templates/new.json
  def new
    @admin_template_source = TemplateSource.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_template_source }
    end
  end

  # GET /templates/1/edit
  def edit
    @admin_template_source = TemplateSource.find(params[:id])
  end

  # POST /admin/templates
  # POST /admin/templates.json
  def create
    @admin_template_source = TemplateSource.new(params[:admin_template_source])
    @admin_template_source.user_id=current_user.id

    respond_to do |format|
      if @admin_template_source.save
        format.html { redirect_to admin_template_source_types_url, notice: '공지사항이 작성되었습니다.' }
        format.json { render json: @admin_template_source, status: :created, location: @admin_template_source }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_template_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/templates/1
  # PUT /admin/templates/1.json
  def update
    @admin_template_source = TemplateSource.find(params[:id])

    respond_to do |format|
      if @admin_template_source.update_attributes(params[:admin_template_source])
        format.html { redirect_to admin_template_source_types_url, notice: '공지사항이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_template_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/templates/1
  # DELETE /admin/templates/1.json
  def destroy
    @admin_template_source = TemplateSource.find(params[:id])
    @admin_template_source.destroy

    respond_to do |format|
      format.html { redirect_to admin_template_source_types_url }
      format.json { head :no_content }
    end
  end
end
