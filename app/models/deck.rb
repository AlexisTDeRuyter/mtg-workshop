class Deck < ActiveRecord::Base
  validates :name, :format, :user_id, presence: true

  belongs_to :user
  has_many :card_decks, dependent: :destroy
  has_many :cards, through: :card_decks
end
