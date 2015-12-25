class AddSharedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :shared, :boolean
  end
end
