get '/decks/:id' do
  @deck = Deck.find(params[:id])
  halt(404, slim(:'404')) unless @deck.user == current_user
  slim :'decks/show'
end

post '/decks' do
  halt(404, slim(:'404')) unless logged_in?
  params[:deck][:user] = current_user
  deck = Deck.create(params[:deck])
  if request.xhr?
    if deck.save
      content_type :json
      {content: (slim :'decks/_list_deck', layout: false, locals: {deck: deck})}.to_json
    else
      status 422
      @errors = deck.errors.full_messages
      slim :'_errors', layout: false
    end
  else
    if deck.save
      redirect '/profile'
    else
      @deck_errors = true
      @errors = deck.errors.full_messages
      slim :'users/profile'
    end
  end
end

post '/decks/:id/main/new' do
  @deck = Deck.find(params[:id])
  halt(404, slim(:'404')) unless @deck.user == current_user
  card_type = CardType.find_or_query_for(params[:card_deck][:card_name])
  if card_type.kind_of?(Array)
    @main_errors = true
    @errors = card_type
    halt(404, slim(:'decks/show'))
  end
  card = current_user.cards.find_by(card_type: card_type)
  if !card
    card = Card.create(user: current_user, card_type: card_type, quantity: 0)
  end
  card_deck = CardDeck.find_by(card: card, deck: @deck)
  if card_deck
    new_quantity = card_deck.amount_main + params[:card_deck][:quantity].to_i
    card_deck.update(amount_main: new_quantity)
  else
    card_deck = CardDeck.create(card: card, deck: @deck, amount_main: params[:card_deck][:quantity])
  end
  if card_deck.save
    redirect "/decks/#{@deck.id}"
  else
    @main_errors = true
    @errors = card_deck.errors.full_messages
    slim :'decks/show'
  end
end

post '/decks/:id/side/new' do
  @deck = Deck.find(params[:id])
  halt(404, slim(:'404')) unless @deck.user == current_user
  card_type = CardType.find_or_query_for(params[:card_deck][:card_name])
  if card_type.kind_of?(Array)
    @side_errors = true
    @errors = card_type
    halt(404, slim(:'decks/show'))
  end
  card = current_user.cards.find_by(card_type: card_type)
  if !card
    card = Card.create(user: current_user, card_type: card_type, quantity: 0)
  end
  card_deck = CardDeck.find_by(card: card, deck: @deck)
  if card_deck
    new_quantity = card_deck.amount_side + params[:card_deck][:quantity].to_i
    card_deck.update(amount_side: new_quantity)
  else
    card_deck = CardDeck.create(card: card, deck: @deck, amount_side: params[:card_deck][:quantity])
  end
  if card_deck.save
    redirect "/decks/#{@deck.id}"
  else
    @side_errors = true
    @errors = card_deck.errors.full_messages
    slim :'decks/show'
  end
end

delete '/decks/:deck_id/main/cards/:card_id' do
  @deck = Deck.find(params[:deck_id])
  card_deck = @deck.card_decks.find(params[:card_id])
  if card_deck.amount_side == 0
    card_deck.destroy
  else
    card_deck.update(amount_main: 0)
  end
  redirect :"/decks/#{@deck.id}"
end

delete '/decks/:deck_id/side/cards/:card_id' do
  @deck = Deck.find(params[:deck_id])
  card_deck = @deck.card_decks.find(params[:card_id])
  if card_deck.amount_main == 0
    card_deck.destroy
  else
    card_deck.update(amount_side: 0)
  end
  redirect :"/decks/#{@deck.id}"
end

delete '/decks/:id' do
  Deck.find(params[:id]).destroy
  redirect '/profile'
end
