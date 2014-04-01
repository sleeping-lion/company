# encoding: utf-8

class MaintainController < ApplicationController
  before_action :authenticate_user!, :except => [:index,:show]  
  before_action :set_maintain, only: [:show, :edit, :update, :destroy]    
  
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.maintain')
  end

  # GET /portfolios
  # GET /portfolios.json
  def index
    @maintain = Maintain.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @maintains }
    end
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @maintain }
    end
  end

  # GET /portfolios/new
  # GET /portfolios/new.json
  def new
    @maintain = Maintain.new
    @maintain.build_maintain_content    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @maintain }
    end
  end

  # GET /portfolios/1/edit
  def edit
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @maintain = Maintain.new(maintain_params)

    respond_to do |format|
      if @maintain.save
        format.html { redirect_to @maintain, notice: @controller_name +t(:message_success_create)}
        format.json { render json: @maintain, status: :created, location: @maintain }
      else
        format.html { render action: "new" }
        format.json { render json: @maintain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /portfolios/1
  # PUT /portfolios/1.json
  def update
    respond_to do |format|
      if @maintain.update_attributes(maintain_params)
        format.html { redirect_to @maintain, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @maintain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @maintain.destroy

    respond_to do |format|
      format.html { redirect_to maintain_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_maintain
    @maintain = Maintain.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def maintain_params
    params.require(:maintain).permit(:id,:title,:price,:description,product_content_attributes: [:id,:content])
  end  
end