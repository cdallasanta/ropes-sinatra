class ElementController < ApplicationController
  #displaya all elements, their ropes, and those ropes' climb counts
  get '/elements' do
    check_logged_in

    @elements = Element.all
    erb :'elements/index'
  end
end
