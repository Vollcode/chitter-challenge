ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require './app/data_mapper_setup'

class Chitter < Sinatra::Base

  enable :sessions

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :'peeps/homepage'
  end

  get '/users' do
    erb :'users/new'
  end

  post '/userdata' do
    user = User.create(username: params[:username],name: params[:name],email: params[:email],password: params[:password])
    p user
    session[:user_id] = user.id
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
