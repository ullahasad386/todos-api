class AddCategoryIdToTodosAndRemoveTodoIdFromCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :category_id, :integer
    remove_column :categories, :todo_id
  end
end
