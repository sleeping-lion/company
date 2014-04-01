# encoding: utf-8

class Admin::MenusController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='FAQ'
  end

  # GET /admin/menus
  # GET /admin/menus.json
  def index
    @admin_menus = Menu.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /admin/menus/1
  # GET /admin/menus/1.json
  def show
    @admin_menu = Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /admin/menus/new
  # GET /admin/menus/new.json
  def new
    @admin_menu = Menu.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_menu }
    end
  end

  # GET /admin/menus/1/edit
  def edit
    @admin_menu = Menu.find(params[:id])
  end

  # POST /admin/menus
  # POST /admin/menus.json
  def create
    @admin_menu = Menu.new(params[:menu])

    respond_to do |format|
      if @admin_menu.save
        format.html { redirect_to admin_menus_url, notice: '공지사항이 작성되었습니다.' }
        format.json { render json: @admin_menu, status: :created, location: @admin_menu }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/menus/1
  # PUT /admin/menus/1.json
  def update
    @admin_menu = Menu.find(params[:id])

    respond_to do |format|
      if @admin_menu.update_attributes(params[:menu])
        format.html { redirect_to admin_menus_url, notice: '공지사항이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/menus/1
  # DELETE /admin/menus/1.json
  def destroy
    @admin_menu = Menu.find(params[:id])
    @admin_menu.destroy

    respond_to do |format|
      format.html { redirect_to admin_menus_url }
      format.json { head :no_content }
    end
  end
end
