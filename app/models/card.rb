class Card < ActiveRecord::Base
  validates :card_type_id, :user_id, :quantity, presence: true

  belongs_to :card_type
  has_many :card_decks
  has_many :decks, through: :card_decks
  belongs_to :user

  scope :actual, ->{ where("quantity > 0") }

end
