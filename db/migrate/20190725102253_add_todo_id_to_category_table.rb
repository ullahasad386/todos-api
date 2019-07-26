class AddTodoIdToCategoryTable < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :todo_id, :integer
  end
end
