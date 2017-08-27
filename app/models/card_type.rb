class CardType < ActiveRecord::Base
  validates :scryfall_id, :name, :data, presence: true
  validates :scryfall_id, :name, uniqueness: true

  has_many :cards

  def self.find_or_query_for(name)
    card_type = self.where("name ILIKE ?", "%#{name}%").first
    if !card_type
      begin
        response = RestClient.get('https://api.scryfall.com/cards/named', params: {fuzzy: name})
      rescue
        @errors = ['Card could not be found']
        return @errors
      end
      if !@errors
        parsed_response = JSON.parse(response.body)
        card_type = CardType.create!(scryfall_id: parsed_response['id'], name: parsed_response['name'], data: parsed_response)
      end
    end
    card_type
  end
end
