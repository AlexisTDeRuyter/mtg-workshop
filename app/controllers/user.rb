get '/register' do
  @user = User.new
  slim :'users/new'
end

post '/users' do
  @user = User.create(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect :"/profile"
  else
    status 422
    @errors = @user.errors.full_messages
    slim :'users/new'
  end
end

get '/profile' do
  halt(404, slim(:'404')) unless logged_in?
  slim :'/users/profile'
end
