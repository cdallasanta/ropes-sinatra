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
      flash[:type] = "error"
      flash[:message] = "You must be signed in as that user to view their page"
      redirect '/'
    end
  end

  post '/users' do
    user = User.new(params)

    # if successful, move to homepage, otherwise, try again
    # with errors displayed
    if user.save && user.username != ""
      session[:user_id] = user.id
      redirect '/'
    else
      # these flash error messages don't work, no one knows why
      # the redirect still works though
      flash[:type] = "error"
      all_errors = []
      user.errors.messages.each do |attr, error_message|
        all_errors << error_message[0]
      end
      flash[:message] = all_errors

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
    user = User.find_by(username:params[:username])

    # these flash error messages don't work, no one knows why
    # the redirect still works though
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/'
    elsif user == nil
      flash[:type] = "error"
      flash[:message] = ["Cannot find a user by that name"]

      redirect '/login'
    else
      flash[:type] = "error"
      flash[:message] = ["Password is incorrect"]

      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end
end
