class UserController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect '/login'
    else
      erb :'users/signup'
    end
  end

  get '/users/:id' do
    if current_user == User.find(params[:id])
      erb :'/users/show'
    else
      #TODO flash error message
      redirect '/'
    end
  end

  post '/users' do
    #TODO redirecting with flash message on errors
    user = User.new(params)

    if user.save && user.username != ""
      session[:user_id] = user.id
      redirect '/'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/'
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    #TODO flash message for errors
    user = User.find_by(username:params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end
end
