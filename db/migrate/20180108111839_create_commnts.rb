class CreateCommnts < ActiveRecord::Migration[5.1]
  def change
    create_table :commnts do |t|
        t.text "comment"
        t.integer "user_id"
        t.datetime "created_at"
        t.datetime "updated_at"
    end
  end
end
