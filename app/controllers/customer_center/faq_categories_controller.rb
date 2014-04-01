# encoding: utf-8

class CustomerCenter::FaqCategoriesController < BoardController
  before_filter :authenticate_user!, :except => [:index,:show]
    
  # GET /faq_categories
  # GET /faq_categories.json
  def index
    @faq_categories = FaqCategory.order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @faq_categories }
    end
  end

  # GET /faq_categories/1
  # GET /faq_categories/1.json
  def show
    @faq_category = FaqCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @faq_category }
    end
  end

  # GET /faq_categories/new
  # GET /faq_categories/new.json
  def new
    @faq_category = FaqCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @faq_category }
    end
  end

  # GET /faq_categories/1/edit
  def edit
    @faq_category = FaqCategory.find(params[:id])
  end

  # POST /faq_categories
  # POST /faq_categories.json
  def create
    @faq_category = FaqCategory.new(params[:faq_category])

    respond_to do |format|
      if @faq_category.save
        format.html { redirect_to customer_center_faqs_url(:faq_category_id=>@faq_category), notice: 'Faq category was successfully created.' }
        format.json { render json: @faq_category, status: :created, location: @faq_category }
      else
        format.html { render action: "new" }
        format.json { render json: @faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /faq_categories/1
  # PUT /faq_categories/1.json
  def update
    @faq_category = FaqCategory.find(params[:id])

    respond_to do |format|
      if @faq_category.update_attributes(params[:faq_category])
        format.html { redirect_to customer_center_faqs_url(:faq_category_id=>@faq_category), notice: 'Faq category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faq_categories/1
  # DELETE /faq_categories/1.json
  def destroy
    @faq_category = FaqCategory.find(params[:id])
    @faq_category.destroy

    respond_to do |format|
      format.html { redirect_to customer_center_faqs_url }
      format.json { head :ok }
    end
  end
end
