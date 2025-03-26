class CommentsController < ApplicationController
  before_action :set_recipe

  # Create a rating for a specific comment on a recipe
  def create_rating
    @comment = @recipe.comments.new(comment_params)
    @comment.rating = params[:comment][:rating] # Getting the rating from the form input

    if @comment.save
      flash[:notice] = "Rating added successfully!"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "There was an issue with your rating."
      render 'recipes/show'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :rating) # Adjust if needed
  end
end
