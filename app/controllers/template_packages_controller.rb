# encoding: utf-8

class TemplatePackagesController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_template_package, only: [:show, :edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.template_package')
  end  
  
  # GET /template_packages
  # GET /template_packages.json
  def index
    @template_packages=TemplateAuthor.find(:all,:conditions=>{:enable=>true})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @template_packages }
    end
  end

  # GET /template_packages/1
  # GET /template_packages/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @template_package }
    end
  end

  # GET /template_packages/new
  # GET /template_packages/new.json
  def new
    @template_package = TemplateAuthor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @template_package }
    end
  end

  # GET /template_packages/1/edit
  def edit
  end

  # POST /template_packages
  # POST /template_packages.json
  def create
    @template_package = TemplateAuthor.new(template_package_params)

    respond_to do |format|
      if @template_package.save
        format.html { redirect_to @template_package, notice: @controller_name +t(:message_success_create)}
        format.json { render json: @template_package, status: :created, location: @template_package }
      else
        format.html { render action: "new" }
        format.json { render json: @template_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /template_packages/1
  # PUT /template_packages/1.json
  def update
    respond_to do |format|
      if @template_package.update_attributes(template_package_params)
        format.html { redirect_to @template_package, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @template_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_packages/1
  # DELETE /template_packages/1.json
  def destroy
    @template_package.destroy

    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_template_package
    @template_package = TemplateAuthor.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def template_package_params
    params.require(:template_package).permit(:id,:name)
  end  
end
