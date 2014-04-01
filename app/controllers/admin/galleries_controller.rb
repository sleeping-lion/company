# encoding: utf-8

class Admin::GalleriesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='갤러리'
  end
    
  # GET /admin/galleries
  # GET /admin/galleries.json
  def index
    @admin_gallery_categories=GalleryCategory.all
    
    if(params[:gallery_category_id])
      @categoryId=params[:gallery_category_id].to_i
    else
      if @admin_gallery_categories[0]
        @categoryId=@admin_gallery_categories[0].id.to_i
      else
        @categoryId=nil        
      end
    end
    
    @admin_galleries = Gallery.where(:gallery_category_id=>@categoryId).order('id desc').page(params[:page]).per(10)
    
    if(params[:id])
      @admin_gallery = Gallery.find(params[:id])
    else
      @admin_gallery=@admin_galleries[0]
    end
    
    @script='galleries'    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_galleries }
    end
  end
  
  # GET /admin/galleries/1
  # GET /admin/galleries/1.json
  def show
    @admin_gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_gallery }
    end
  end
  
  # GET /admin/galleries/new
  # GET /admin/galleries/new.json
  def new
    @admin_gallery = Gallery.new
    @admin_gallery_categories=GalleryCategory.all
    @admin_gallery_category_id=params[:gallery_category_id]      
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @admin_gallery }
    end
  end
  
  # GET /admin/galleries/1/edit
  def edit
    @admin_gallery = Gallery.find(params[:id])
    @admin_gallery_categories=GalleryCategory.all
    @admin_gallery_category_id=@admin_gallery.gallery_category.id    
  end
  
  # POST /admin/galleries
  # POST /admin/galleries.json
  def create
    @admin_gallery = Gallery.new(params[:gallery])
    
    respond_to do |format|
      if @admin_gallery.save
        format.html { redirect_to admin_galleries_url(:gallery_category_id=>@admin_gallery.gallery_category_id), :notice => '갤러리 사진이 등록되었습니다.' }
        format.json { render :json => @admin_gallery, :status => :created, :location => @admin_gallery }
      else
        format.html { render :action => "new" }
        format.json { render :json => @admin_gallery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /admin/galleries/1
  # PUT /admin/galleries/1.json
  def update
    @admin_gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      if @admin_gallery.update_attributes(params[:gallery])
        format.html { redirect_to admin_galleries_url(:gallery_category_id=>@admin_gallery.gallery_category_id), :notice => '갤러리 사진이 수정되었습니다.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_gallery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admin/galleries/1
  # DELETE /admin/galleries/1.json
  def destroy
    @admin_gallery = Gallery.find(params[:id])
    @admin_gallery.destroy
    
    respond_to do |format|
      format.html { redirect_to admin_galleries_url(:gallery_category_id=>@admin_gallery.gallery_category_id) }
      format.json { head :ok }
    end
  end
end
