# encoding: utf-8

class Admin::ProductsController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='제품'
  end
  
  # GET /products
  # GET /products.json
  def index
    @admin_products = Product.order('id desc').page(params[:page]).per(50)    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @admin_product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @admin_product = Product.new
    @admin_product.build_product_content    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @admin_product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @admin_product = Product.new(params[:product])

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to admin_products_url, notice: 'Product was successfully created.' }
        format.json { render json: @admin_product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @admin_product = Product.find(params[:id])

    respond_to do |format|
      if @admin_product.update_attributes(params[:product])
        format.html { redirect_to admin_products_url, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @admin_product = Product.find(params[:id])
    @admin_product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url }
      format.json { head :no_content }
    end
  end
end
