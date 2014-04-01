# encoding: utf-8

class TemplateAuthorsController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_template_author, only: [:show, :edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.template_author')
  end  
  
  # GET /template_authors
  # GET /template_authors.json
  def index
    @template_authors=TemplateAuthor.find(:all,:conditions=>{:enable=>true})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @template_authors }
    end
  end

  # GET /template_authors/1
  # GET /template_authors/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @template_author }
    end
  end

  # GET /template_authors/new
  # GET /template_authors/new.json
  def new
    @template_author = TemplateAuthor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @template_author }
    end
  end

  # GET /template_authors/1/edit
  def edit
  end

  # POST /template_authors
  # POST /template_authors.json
  def create
    @template_author = TemplateAuthor.new(template_author_params)

    respond_to do |format|
      if @template_author.save
        format.html { redirect_to @template_author, notice: @controller_name +t(:message_success_create)}
        format.json { render json: @template_author, status: :created, location: @template_author }
      else
        format.html { render action: "new" }
        format.json { render json: @template_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /template_authors/1
  # PUT /template_authors/1.json
  def update
    respond_to do |format|
      if @template_author.update_attributes(template_author_params)
        format.html { redirect_to @template_author, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @template_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_authors/1
  # DELETE /template_authors/1.json
  def destroy
    @template_author.destroy

    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_template_author
    @template_author = TemplateAuthor.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def template_author_params
    params.require(:template_author).permit(:id,:name)
  end  
end
