post '/cards' do
  cardtype = CardType.find_by(name: params[:name])
  if !cardtype
    response = RestClient.get('https://api.scryfall.com/cards/named', params: {fuzzy: params[:card][:name]})
    parsed_response = JSON.parse(response.body)
    cardtype = CardType.create(scryfall_id: parsed_response['id'], name: parsed_response['name'], data: parsed_response)
  end
  puts current_user.username
  card = Card.create(card_type: cardtype, quantity: params[:card][:quantity], user: current_user)
  if card.save
    redirect '/profile'
  else
    @errors = card.errors.full_messages
    slim :'users/profile'
  end
end
