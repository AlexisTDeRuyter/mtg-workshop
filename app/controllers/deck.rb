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
  card = current_user.cards.find_by(card_type: card_type)
  if !card
    card = Card.create(user: current_user, card_type: card_type, quantity: 0)
  end
  card_deck = CardDeck.find_by(card: card, deck: deck)
  if card_deck
    new_quantity = card_deck.amount_main + params[:card_deck][:quantity].to_i
    card_deck.update(amount_main: new_quantity)
  else
    card_deck = CardDeck.create(card: card, deck: deck, amount_main: params[:card_deck][:quantity])
  end
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
  card = current_user.cards.find_by(card_type: card_type)
  if !card
    card = Card.create(user: current_user, card_type: card_type, quantity: 0)
  end
  card_deck = CardDeck.find_by(card: card, deck: deck)
  if card_deck
    new_quantity = card_deck.amount_side + params[:card_deck][:quantity].to_i
    card_deck.update(amount_side: new_quantity)
  else
    card_deck = CardDeck.create(card: card, deck: deck, amount_side: params[:card_deck][:quantity])
  end
  if card_deck.save
    redirect "/decks/#{deck.id}"
  else
    slim :'decks/show'
  end
end
