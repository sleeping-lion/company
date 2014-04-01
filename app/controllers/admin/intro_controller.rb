# encoding: utf-8

class Admin::IntroController < Admin::AdminController
  # GET /menus
  # GET /menus.json
  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @admin_intro = Intro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @admin_intro = Intro.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_intro }
    end
  end

  # GET /menus/1/edit
  def edit
    @admin_intro = Intro.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    @admin_intro = Intro.new(params[:menu])

    respond_to do |format|
      if @admin_intro.save
        format.html { redirect_to @admin_intro, notice: '공지사항이 작성되었습니다.' }
        format.json { render json: @admin_intro, status: :created, location: @admin_intro }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_intro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @admin_intro = Intro.find(params[:id])

    respond_to do |format|
      if @admin_intro.update_attributes(params[:menu])
        format.html { redirect_to @admin_intro, notice: '공지사항이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_intro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @admin_intro = Intro.find(params[:id])
    @admin_intro.destroy

    respond_to do |format|
      format.html { redirect_to admin_menus_url }
      format.json { head :no_content }
    end
  end
end
