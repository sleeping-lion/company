# encoding: utf-8

class Admin::TemplatePackagesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='Template Packages'
  end
 
  # GET /admin/templates
  # GET /admin/templates.json
  def index
    @admin_template_packages = TemplatePackage.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_template_package_types }
    end
  end

  # GET /admin/templates/1
  # GET /admin/templates/1.json
  def show
    @admin_template_package = TemplatePackage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_template_package }
    end
  end

  # GET /admin/templates/new
  # GET /admin/templates/new.json
  def new
    @admin_template_package = TemplatePackage.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_template_package }
    end
  end

  # GET /templates/1/edit
  def edit
    @admin_template_package = TemplatePackage.find(params[:id])
  end

  # POST /admin/templates
  # POST /admin/templates.json
  def create
    @admin_template_package = TemplatePackage.new(params[:admin_template_package])

    respond_to do |format|
      if @admin_template_package.save
        format.html { redirect_to admin_template_package_url, notice: '공지사항이 작성되었습니다.' }
        format.json { render json: @admin_template_package, status: :created, location: @admin_template_package }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_template_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/templates/1
  # PUT /admin/templates/1.json
  def update
    @admin_template_package = TemplatePackage.find(params[:id])

    respond_to do |format|
      if @admin_template_package.update_attributes(params[:admin_template_package])
        format.html { redirect_to admin_template_package_url, notice: '공지사항이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_template_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/templates/1
  # DELETE /admin/templates/1.json
  def destroy
    @admin_template_package = TemplatePackage.find(params[:id])
    @admin_template_package.destroy

    respond_to do |format|
      format.html { redirect_to admin_template_package_url }
      format.json { head :no_content }
    end
  end
end
