class AddSetTimeInItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :set_time, :datetime
  end
end
