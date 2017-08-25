class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.integer :card_type_id, null: false
      t.integer :user_id, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
