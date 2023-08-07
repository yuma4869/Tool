class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, force: :cascade do |t|
      t.string "content"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "title"
      t.string "time"
      t.integer "user_id", null: false
      t.string "name"
      t.integer "row_order"
      t.index ["user_id"], name: "index_tasks_on_user_id"
    end
  end
end
