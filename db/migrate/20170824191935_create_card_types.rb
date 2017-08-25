class CreateCardTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :card_types do |t|
      t.string :scryfall_id, unique: true, null: false
      t.string :name, unique: true, null: false
      t.jsonb :data, null: false

      t.timestamps
    end
  end
end
