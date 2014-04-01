# encoding: utf-8

class Admin::FaqsController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='FAQ'
  end
  
  # GET /admin/faqs
  # GET /admin/faqs.json
  def index
    @admin_faq_categories = FaqCategory.all
    
    if(params[:faq_category_id])
      @categoryId=params[:faq_category_id].to_i
    else
      if @admin_faq_categories[0]
        @categoryId=@admin_faq_categories[0].id.to_i
      else
        @categoryId=nil        
      end
    end
    
    @admin_faqs = Faq.where(:faq_category_id=>@categoryId).order('id desc').page(params[:page]).per(10)
    
    if(params[:id])
      @admin_faq = Faq.find(params[:id])
    end
    
    @script='faqs'
    
    admin=false
    if(current_user)
      if(current_user.admin)
        admin=true
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {:faqs=>@admin_faqs,:admin=>admin} }
    end
  end
  
  # GET /admin/faqs/1
  # GET /admin/faqs/1.json
  def show
    @admin_faqContent=FaqContent.find(params[:id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_faqContent }
    end
  end
  
  # GET /admin/faqs/new
  # GET /admin/faqs/new.json
  def new
    @admin_faq = Faq.new
    @admin_faq.build_faq_content
    @admin_faq_categories = FaqCategory.all
    @admin_faq_category_id=params[:faq_category_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_faq }
    end
  end
  
  # GET /admin/faqs/1/edit
  def edit
    @admin_faq = Faq.find(params[:id])
    @admin_faq_categories = FaqCategory.all
    @admin_faq_category_id=@admin_faq.faq_category.id
  end
  
  # POST /admin/faqs
  # POST /admin/faqs.json
  def create
    @admin_faq = Faq.new(params[:faq])
    
    respond_to do |format|
      if @admin_faq.save
        format.html { redirect_to faqs_url(:faq_category_id=>@admin_faq.faq_category.id), notice: 'Faq was successfully created.' }
        format.json { render json: @admin_faq, status: :created, location: @admin_faq }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_faq.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /admin/faqs/1
  # PUT /admin/faqs/1.json
  def update
    @admin_faq = Faq.find(params[:id])
    
    respond_to do |format|
      if @admin_faq.update_attributes(params[:faq])
        format.html { redirect_to faqs_url(:faq_category_id=>@admin_faq.faq_category.id), notice: 'Faq was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_faq.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admin/faqs/1
  # DELETE /admin/faqs/1.json
  def destroy
    @admin_faq = Faq.find(params[:id])
    @admin_faq.destroy
    
    respond_to do |format|
      format.html { redirect_to faqs_url(:faq_category_id=>@admin_faq.faq_category.id) }
      format.json { head :ok }
    end
  end
end