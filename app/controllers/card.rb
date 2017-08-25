post '/cards' do
  halt(404, slim(:'404')) unless logged_in
  cardtype = CardType.find_or_query_for(params[:card][:name])
  card = Card.new(card_type: cardtype, quantity: params[:card][:quantity], user: current_user)
  if card.save
    redirect '/profile'
  else
    @errors = card.errors.full_messages
    slim :'users/profile'
  end
end
