class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    @categories = current_user.categories
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Listing all categories'}, data: @categories},
    status: :ok
  end

  def create
    @category = current_user.categories.create!(category_params)
    if @category.save
      render json: { meta: {status: 'SUCCESS', code: 200, message: 'Saved Category'}, data: @category}, status: :ok
    else
      render json: { meta: {status: 'ERROR', code: 422, message: 'Category not saved'}, data: @category.errors},
      status: :unprocessable_entity
    end
  end

  def show
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Loaded category and its todos'}, data: { category: @category,
    todos:  @category.todos }}, status: :ok
  end

  def update
    if @category.update(category_params)
      render json: { meta: {status: 'SUCCESS', code: 200, message: 'Updated Category'}, data: @category}, status: :ok
    else
      render json: { meta: {status: 'ERROR', code: 422, message: 'Category not updated'}, data: @category.errors},
      status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Deleted category'}, data: @category}, status: :ok
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
