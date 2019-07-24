class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = current_user.todos
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Listing all todos'}, data: @todos},
    status: :ok
  end

  def create
    @todo = current_user.todos.create!(todo_params)
    if @todo.save
      render json: { meta: {status: 'SUCCESS', code: 200, message: 'Saved Todo'}, data: @todo}, status: 200
    else
      render json: { meta: {status: 'ERROR', code: 422, message: 'Todo not saved'}, data: @todo.errors},
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
        render json: { meta: {status: 'ERROR', code: 422, message: 'Todo not updated'}, data: @todo.errors},
        status: :unprocessable_entity
      end
  end

  private

  def todo_params
    params.permit(:title)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end

  end
