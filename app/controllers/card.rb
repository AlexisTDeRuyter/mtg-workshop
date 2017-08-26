get '/cards/:id' do
  @card_type = CardType.find(params[:id])
  slim :'cards/show'
end

post '/cards' do
  halt(404, slim(:'404')) unless logged_in?
  cardtype = CardType.find_or_query_for(params[:card][:name])
  card = Card.where(card_type: cardtype)
  if card.any?
    card.first.quantity += params[:card][:quantity].to_i
    card.first.save
    redirect '/profile'
  else
    card = Card.new(card_type: cardtype, quantity: params[:card][:quantity], user: current_user)
    if card.save
      redirect '/profile'
    else
      @errors = card.errors.full_messages
      slim :'users/profile'
    end
  end
end
