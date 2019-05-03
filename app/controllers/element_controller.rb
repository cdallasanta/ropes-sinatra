class ElementController < ApplicationController
  get '/elements' do
    check_logged_in

    @elements = Element.all
    erb :'elements/index'
  end
end
