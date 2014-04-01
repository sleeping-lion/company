# encoding: utf-8

class GalleriesController < BoardController
  before_filter :authenticate_user!, :except => [:index,:show]  
  
  def initialize(*params)
    super(*params)
    @style='galleries'
    @script='galleries'
    @controller_name='사진첩'
  end
  
  # GET /galleries
  # GET /galleries.json
  def index
    @gallery_categories=GalleryCategory.all
    
    if(params[:gallery_category_id])
      @categoryId=params[:gallery_category_id].to_i
    else
      if @gallery_categories[0]
        @categoryId=@gallery_categories[0].id.to_i
      else
        @categoryId=nil        
      end
    end
    
    @galleries = Gallery.where(:gallery_category_id=>@categoryId).order('id desc').page(params[:page]).per(10)
    
    if(params[:id])
      @gallery = Gallery.find(params[:id])
    else
      @gallery=@galleries[0]
    end
    
    @script='galleries'    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @galleries }
    end
  end
  
  # GET /galleries/1
  # GET /galleries/1.json
  def show
    @gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @gallery }
    end
  end
  
  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @gallery = Gallery.new
    @gallery_categories=GalleryCategory.all
    @gallery_category_id=params[:gallery_category_id]      
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @gallery }
    end
  end
  
  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
    @gallery_categories=GalleryCategory.all
    @gallery_category_id=@gallery.gallery_category.id    
  end
  
  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(params[:gallery])
    
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to galleries_url(:gallery_category_id=>@gallery.gallery_category_id), :notice => '갤러리 사진이 등록되었습니다.' }
        format.json { render :json => @gallery, :status => :created, :location => @gallery }
      else
        format.html { render :action => "new" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /galleries/1
  # PUT /galleries/1.json
  def update
    @gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to galleries_url(:gallery_category_id=>@gallery.gallery_category_id), :notice => '갤러리 사진이 수정되었습니다.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    
    respond_to do |format|
      format.html { redirect_to galleries_url(:gallery_category_id=>@gallery.gallery_category_id) }
      format.json { head :ok }
    end
  end
end
