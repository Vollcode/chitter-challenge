ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require './app/data_mapper_setup'

require 'sinatra/flash'

class Chitter < Sinatra::Base
  use Rack::MethodOverride
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :'peeps/homepage'
  end

  get '/latestpeeps' do
    erb :'peeps/allpeeps'
  end

  post '/peeps' do
    user = User.get(session[:user_id])
    peep = Peep.create(title: params[:title],content: params[:content],time: params[:time])
    p peep
    user.peeps << peep
    user.save
    redirect '/latestpeeps'
  end

  post '/userdata' do
    user = User.create(username: params[:username],name: params[:name],email: params[:email],password: params[:password],password_confirmation: params[:password_confirmation])
    p user.errors
    session[:user_id] = user.id
    redirect '/'
  end

  get '/log_in' do
    erb :'users/log'
  end

  post '/logged_in' do
      user = User.authenticate(params[:username], params[:password_digest])
    if user
      session[:user_id] = user.id
      redirect '/latestpeeps'
    else
      flash.next[:errors] = ['The email or password is incorrect']
      redirect '/latestpeeps'
    end
  end

  get '/users' do
    erb :'users/new'
  end

  delete '/sessions' do
  session[:user_id] = nil
  flash.keep[:notice] = 'goodbye!'
  redirect to '/'
end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
