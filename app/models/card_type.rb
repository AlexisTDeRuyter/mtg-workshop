class CardType < ActiveRecord::Base
  validates :scryfall_id, :name, :data, presence: true
  validates :scryfall_id, :name, uniqueness: true

  has_many :cards
end
