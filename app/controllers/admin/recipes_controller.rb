# encoding: utf-8

class Admin::RecipesController < Admin::AdminController
  def initialize(*params)
    super(*params)
    @controller_name='수정이 요리'
  end
  
  # GET /admin/recipes
  # GET /admin/recipes.json
  def index
    @admin_recipe_categories=RecipeCategory.all
    
    if(params[:recipe_category_id])
      @categoryId=params[:recipe_category_id].to_i
    else
      if @admin_recipe_categories[0]
        @categoryId=@admin_recipe_categories[0].id.to_i
      else
        @categoryId=nil        
      end
    end
    
    @admin_recipes = Recipe.where(:recipe_category_id=>@categoryId).order('id desc').page(params[:page]).per(5)
         
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_recipes }
    end
  end

  # GET /admin/recipes/1
  # GET /admin/recipes/1.json
  def show
    @admin_recipe = Recipe.find(params[:id])
    @admin_recipe_comments=@admin_recipe.recipe_comment.order('id desc').page(params[:page]).per(10)         

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_recipe }
    end
  end

  # GET /admin/recipes/new
  # GET /admin/recipes/new.json
  def new
    @admin_recipe = Recipe.new
    @admin_recipe.build_recipe_content
    @admin_recipe_categories=RecipeCategory.all
    @script='board/new'
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_recipe }
    end
  end

  # GET /admin/recipes/1/edit
  def edit
    @admin_recipe = Recipe.find(params[:id])
    @admin_recipe_categories=RecipeCategory.all
    @admin_recipe_category_id=@admin_recipe.recipe_category.id    
    @script='board/edit'
  end

  # POST /admin/recipes
  # POST /admin/recipes.json
  def create
    @admin_recipe = Recipe.new(params[:recipe])

    respond_to do |format|
      if @admin_recipe.save
        format.html { redirect_to @admin_recipe, notice: '요리법이 작성되었습니다.' }
        format.json { render json: @admin_recipe, status: :created, location: @admin_recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/recipes/1
  # PUT /admin/recipes/1.json
  def update
    @admin_recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @admin_recipe.update_attributes(params[:recipe])
        format.html { redirect_to @admin_recipe, notice: '요리법이 수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/recipes/1
  # DELETE /admin/recipes/1.json
  def destroy
    @admin_recipe = Recipe.find(params[:id])
    @admin_recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end
end
