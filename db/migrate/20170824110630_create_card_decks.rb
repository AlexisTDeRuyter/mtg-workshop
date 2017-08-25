class CreateCardDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :card_decks do |t|
      t.integer :card_id, null: false
      t.integer :deck_id, null: false
      t.integer :amount_main, null: false, default: 0
      t.integer :amount_side, null: false, default: 0

      t.timestamps
    end
  end
end
