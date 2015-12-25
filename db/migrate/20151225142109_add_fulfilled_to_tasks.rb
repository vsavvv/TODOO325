class AddFulfilledToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :fulfilled, :integer
  end
end
