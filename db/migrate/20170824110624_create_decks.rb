class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :name, null: false
      t.string :format, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
