class Create2Comments < ActiveRecord::Migration[5.1]
  def change
    create_table "comments", force: :cascade do |t|
      t.text "comment"
      t.integer "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
