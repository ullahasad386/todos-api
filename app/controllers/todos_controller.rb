class TodosController < ApplicationController
  #before_action :set_todo, only: [:show, :update, :destroy]
  before_action :set_category
  before_action :set_category_todo, only: [:show, :update, :destroy]
  

  def index
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Listing all todos'}, data: @category.todos},
    status: :ok
  end

  def create
    @todoo = @category.todos.create!(todo_params)
    if @todoo.save
      render json: { meta: {status: 'SUCCESS', code: 200, message: 'Saved Todo'}, data: @todoo}, status: 200
    else
      render json: { meta: {status: 'ERROR', code: 422, message: 'Todo not saved'}, data: @category.todos.errors},
      status: :unprocessable_entity
    end
  end

  def show
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Loaded todo'}, data: @todo}, status: :ok
  end

  def destroy
    @todo.destroy
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Deleted Todo'}, data: @todo}, status: 200
  end

  def update
    if @todo.update(todo_params)
        render json: { meta: {status: 'SUCCESS', code: 200, message: 'Updated todo'}, data: @todo}, status: 200
      else
        render json: { meta: {status: 'ERROR', code: 404, message: 'Todo not found'}, data: @todo.errors},
        status: :not_found
      end
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_category_todo
    @todo = @category.todos.find_by!(id: params[:id]) if @category
  end

  #d#ef set_todo
    #@todo = current_user.todos.find(params[:id])
  #end

  end
