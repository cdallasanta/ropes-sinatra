# require 'rack-flash'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  configure do
    set :views, './app/views'
    set :public_folder, './public'
    set :method_override, true
    set :session_secret, ENV["session_secret"]
    enable :sessions
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      erb :index
    else
      redirect '/login'
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end


    def current_user
      # TODO Ruby memoization
      User.find(session[:user_id])
    end

    # called on some of the deeper routes in case someone who's not signed in
    # goes to a url manually
    def check_logged_in
      if !logged_in?
        flash[:type] = "error"
        flash[:message] = ["You must be logged in to view that page"]
        redirect '/login'
      end
    end

    def check_owner(object)
      if current_user != object.user
        flash[:type] = "error"
        flash[:message] = ["You must be signed in as the owner to view or edit it"]
        redirect '/'
      end
    end
  end
end
