class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @recipe = Recipe.all.order("created_at DESC")
  end

  def show
    if signed_in?
      @new_comment = Comment.build_from(@recipe, current_user.id, "")
    else
      @all_comments = @recipe.comment_threads
    end    
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = "Successfully created new recipe"
      redirect_to @recipe 
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Successfully updated recipe"
      redirect_to @recipe 
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    flash[:danger] = "Successfully deleted recipe"
    redirect_to root_path
  end

  private

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :image,
                      ingredients_attributes: [:id, :name, :_destroy],
                      directions_attributes: [:id, :step, :_destroy])
    end

    def require_same_user
      if current_user != @recipe.user
        flash[:danger] = "You can edit or delete only your recipe"
        redirect_to root_path
      end
      
    end
end
