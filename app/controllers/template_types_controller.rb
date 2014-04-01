# encoding: utf-8

class TemplateTypesController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_template_type, only: [:show, :edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.template_type')
  end  
  
  # GET /template_types
  # GET /template_types.json
  def index
    @template_types=TemplateAuthor.find(:all,:conditions=>{:enable=>true})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @template_types }
    end
  end

  # GET /template_types/1
  # GET /template_types/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @template_type }
    end
  end

  # GET /template_types/new
  # GET /template_types/new.json
  def new
    @template_type = TemplateAuthor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @template_type }
    end
  end

  # GET /template_types/1/edit
  def edit
  end

  # POST /template_types
  # POST /template_types.json
  def create
    @template_type = TemplateAuthor.new(template_type_params)

    respond_to do |format|
      if @template_type.save
        format.html { redirect_to @template_type, notice: @controller_name +t(:message_success_create)}
        format.json { render json: @template_type, status: :created, location: @template_type }
      else
        format.html { render action: "new" }
        format.json { render json: @template_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /template_types/1
  # PUT /template_types/1.json
  def update
    respond_to do |format|
      if @template_type.update_attributes(template_type_params)
        format.html { redirect_to @template_type, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @template_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_types/1
  # DELETE /template_types/1.json
  def destroy
    @template_type.destroy

    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_template_type
    @template_type = TemplateAuthor.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def template_type_params
    params.require(:template_type).permit(:id,:name)
  end  
end
