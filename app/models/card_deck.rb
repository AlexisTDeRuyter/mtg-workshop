class CardDeck < ActiveRecord::Base
  validates :deck_id, :amount_main, :amount_side, presence: true
  validate :four_limit

  private

  def four_limit
    errors.add(:base, 'Copies cannot exceed 4 between main and sideboard') if self.amount_main + self.amount_side > 4
  end
end
