class ReplaceDoneToStatusAndSetTimeToTimeInItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status, :boolean
    remove_column :items, :done
    add_column :items, :time, :datetime
    remove_column :items, :set_time
  end
end
