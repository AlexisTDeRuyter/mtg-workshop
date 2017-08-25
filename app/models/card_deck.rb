class CardDeck < ActiveRecord::Base
  validates :deck_id, :amount_main, :amount_side, presence: true
  validate :four_limit

  scope :main, ->{ where("amount_main > 0") }
  scope :side, ->{ where("amount_side > 0") }

  belongs_to :card
  belongs_to :deck

  private

  def four_limit
    errors.add(:base, 'Copies cannot exceed 4 between main and sideboard') if self.amount_main + self.amount_side > 4
  end
end
