# encoding: utf-8

class Admin::TemplateTypesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='Template Types'
  end
 
  # GET /admin/template_types
  # GET /admin/template_types.json
  def index
    @admin_template_types = TemplateType.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_template_type_types }
    end
  end

  # GET /admin/template_types/1
  # GET /admin/template_types/1.json
  def show
    @admin_template_type = TemplateType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_template_type }
    end
  end

  # GET /admin/template_types/new
  # GET /admin/template_types/new.json
  def new
    @admin_template_type = TemplateType.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_template_type }
    end
  end

  # GET /template_types/1/edit
  def edit
    @admin_template_type = TemplateType.find(params[:id])
  end

  # POST /admin/template_types
  # POST /admin/template_types.json
  def create
    @admin_template_type = TemplateType.new(params[:admin_template_type])

    respond_to do |format|
      if @admin_template_type.save
        format.html { redirect_to admin_template_type_types_url, notice: '공지사항이 작성되었습니다.' }
        format.json { render json: @admin_template_type, status: :created, location: @admin_template_type }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_template_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/template_types/1
  # PUT /admin/template_types/1.json
  def update
    @admin_template_type = TemplateType.find(params[:id])

    respond_to do |format|
      if @admin_template_type.update_attributes(params[:admin_template_type])
        format.html { redirect_to admin_template_type_types_url, notice: '공지사항이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_template_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/template_types/1
  # DELETE /admin/template_types/1.json
  def destroy
    @admin_template_type = TemplateType.find(params[:id])
    @admin_template_type.destroy

    respond_to do |format|
      format.html { redirect_to admin_template_type_types_url }
      format.json { head :no_content }
    end
  end
end
