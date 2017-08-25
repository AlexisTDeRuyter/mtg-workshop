get '/decks/:id' do
  @deck = Deck.find(params[:id])
  halt(404, slim(:'404')) unless @deck.user == current_user
  slim :'decks/show'
end

post '/decks' do
  halt(404, slim(:'404')) unless logged_in?
  params[:deck][:user] = current_user
  deck = Deck.create(params[:deck])
  if deck.save
    redirect '/profile'
  else
    @errors = card.errors.full_messages
    slim :'users/profile'
  end
end

post '/decks/:id/main/new' do
  deck = Deck.find(params[:id])
  halt(404, slim(:'404')) unless deck.user == current_user
  card_type = CardType.find_or_query_for(params[:card_deck][:card_name])
  card = Card.find_or_create_by(user: current_user, card_type: card_type, quantity: params[:card_deck][:quantity])
  card_deck = CardDeck.create(card: card, deck: deck, amount_main: params[:card_deck][:quantity])
  if card_deck.save
    redirect "/decks/#{deck.id}"
  else
    slim :'decks/show'
  end
end

post '/decks/:id/side/new' do
  deck = Deck.find(params[:id])
  halt(404, slim(:'404')) unless deck.user == current_user
  card_type = CardType.find_or_query_for(params[:card_deck][:card_name])
  card = Card.find_or_create_by(user: current_user, card_type: card_type, quantity: params[:card_deck][:quantity])
  card_deck = CardDeck.create(card: card, deck: deck, amount_side: params[:card_deck][:quantity])
  if card_deck.save
    redirect "/decks/#{deck.id}"
  else
    slim :'decks/show'
  end
end
