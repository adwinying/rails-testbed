class RecipesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :find_recipe, only: [:show, :edit, :update]
	before_action	:back_url, only: [:new, :edit]
	def index
		@recipes = Recipe.all.order("created_at DESC")
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Recipe successfully created."
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @recipe.update_attributes(recipe_params)
			redirect_to @recipe, notice: "Recipe successfully edited."
		else
			render 'edit'
		end
	end

	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy
		redirect_to recipes_path, notice: "Recipe successfully deleted."
	end

	private
	def recipe_params
		params.require(:recipe).permit(:name, 
			:description, 
			:image,
			ingredients_attributes: [:id, :name, :done, :_destroy],
			instructions_attributes: [:id, :step, :done, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

	def back_url 
		@prev_url = URI(request.referer || '').path
	end

end
