class ChangeTimeTypeToStringInItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :time, :datetime
    add_column :items, :time, :string

  end
end
