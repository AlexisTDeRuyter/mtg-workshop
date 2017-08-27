get '/login' do
  @user = User.new
  slim :'sessions/login'
end

post '/login' do
  user_params = params[:user]
  @user = User.authenticate(user_params[:username], user_params[:password])
  if @user
    session[:user_id] = @user.id
    redirect :"/profile"
  else
    status 422
    @errors = ["Login failed"]
    @user = User.new(email: params[:email])
    slim :'sessions/login'
  end
end

delete '/logout' do
  session.delete(:user_id)
  redirect :'/'
end
