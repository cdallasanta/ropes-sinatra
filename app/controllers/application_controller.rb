class ApplicationController < Sinatra::Base

  configure do
    set :views, './app/views'
    set :public_folder, './public'
    set :method_override, true
    set :session_secret, ENV["session_secret"]
    enable :sessions
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
      User.find(session[:user_id])
    end
  end
end
