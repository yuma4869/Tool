class RemoveRankOrderFromTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks,:rank_order,:integer
  end
end
