class Card < ActiveRecord::Base
  validates :card_id, :user_id, :quantity, presence: true

  belongs_to :card_type
  belongs_to :user
end
