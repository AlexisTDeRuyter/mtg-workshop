class Deck < ActiveRecord::Base
  validates :name, :format, :user_id, presence: true

  belongs_to :user
  has_many :card_decks
end
