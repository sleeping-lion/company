# encoding: utf-8

class Admin::FaqCategoriesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='제휴문의'
  end
   
  # GET /admin/faq_categories
  # GET /admin/faq_categories.json
  def index
    @admin_faq_categories = FaqCategory.order('id desc').page(params[:page]).per(10)
    @script='board/faqs/index'
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_faq_categories }
    end
  end

  # GET /admin/faq_categories/1
  # GET /admin/faq_categories/1.json
  def show
    @admin_faq_category = FaqCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_faq_category }
    end
  end

  # GET /admin/faq_categories/new
  # GET /admin/faq_categories/new.json
  def new
    @admin_faq_category = FaqCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_faq_category }
    end
  end

  # GET /admin/faq_categories/1/edit
  def edit
    @admin_faq_category = FaqCategory.find(params[:id])
  end

  # POST /admin/faq_categories
  # POST /admin/faq_categories.json
  def create
    @admin_faq_category = FaqCategory.new(params[:faq_category])

    respond_to do |format|
      if @admin_faq_category.save
        format.html { redirect_to admin_faqs_url(:faq_category_id=>@admin_faq_category), notice: 'Faq category was successfully created.' }
        format.json { render json: @admin_faq_category, status: :created, location: @admin_faq_category }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/faq_categories/1
  # PUT /admin/faq_categories/1.json
  def update
    @admin_faq_category = FaqCategory.find(params[:id])

    respond_to do |format|
      if @admin_faq_category.update_attributes(params[:faq_category])
        format.html { redirect_to admin_faqs_url(:faq_category_id=>@admin_faq_category), notice: 'Faq category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/faq_categories/1
  # DELETE /admin/faq_categories/1.json
  def destroy
    @admin_faq_category = FaqCategory.find(params[:id])
    @admin_faq_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_faqs_url }
      format.json { head :ok }
    end
  end
end
