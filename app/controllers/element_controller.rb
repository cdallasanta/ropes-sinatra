class ElementController < ApplicationController
  get '/elements' do
    if logged_in?
      @elements = Element.all
      erb :'elements/index'
    else
      redirect '/login'
    end
  end
end
