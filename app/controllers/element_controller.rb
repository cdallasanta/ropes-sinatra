class ElementController < ApplicationController
  get '/elements' do
    @elements = Element.all
    erb :'elements/index'
  end
end
