class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_item, only: [:show, :update, :destroy]

  def index
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Listing all items'}, data: @todo.items},
    status: :ok
  end

  def show
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Selected Item'}, data: @item},
    status: :ok
  end

  def create
    @itemm = @todo.items.create!(item_params)
    #json_response(@todo, :created)
    if @itemm.save
      render json: { meta: {status: 'SUCCESS', code: 200, message: 'Saved Item'}, data: @itemm}, status: 200
    else
      render json: { meta: {status: 'ERROR', code: 422, message: 'Item not saved'}, data: @todo.items.errors},
      status: :unprocessable_entity
    end

  end

  def update
    if @item.update(item_params)
      render json: { meta: {status: 'SUCCESS', code: 200, message: 'Updated Item'}, data: @item}, status: 200
    else
      render json: { meta: {status: 'ERROR', code: 422, message: 'Item not updated'}, data: @item.errors},
      status: :unprocessable_entity
    end
    #head :no_content
  end

  def destroy
    @item.destroy
    render json: { meta: {status: 'SUCCESS', code: 200, message: 'Deleted Item'}, data: @item}, status: 200
    #head :no_content
  end

  private

  def item_params
    params.permit(:name, :status, :time)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find_by!(id: params[:id]) if @todo
  end
end
