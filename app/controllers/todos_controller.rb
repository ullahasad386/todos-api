class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = Todo.all
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Listing all todos'}, data: @todos},
    status: :ok
  end

  def create
    @todo = Todo.create!(todo_params)
    if @todo.save
      render json: { meta: {status: 'SUCCESS', code: 201, message: 'Saved Todo'}, data: @todo}, status: :ok
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
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Deleted Todo'}, data: @todo}, status: :ok
  end

  def update
    if @todo.update(todo_params)
        render json: { meta: {status: 'SUCCESS', code: 204, message: 'Updated todo'}, data: @todo}, status: :ok
      else
        render json: { meta: {status: 'ERROR', code: 422, message: 'Todo not updated'}, data: @todo.errors},
        status: :unprocessable_entity
      end
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end

end
