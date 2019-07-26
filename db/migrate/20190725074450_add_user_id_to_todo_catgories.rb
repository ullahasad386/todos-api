class AddUserIdToTodoCatgories < ActiveRecord::Migration[5.2]
  def change
    add_column :todo_categories, :user_id, :integer
    remove_column :todo_categories, :todo_id
  end
end
