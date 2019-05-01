class InspectionController < ApplicationController
  get '/inspections/new' do
    if logged_in?
      @elements = Element.all
      erb :'/inspections/new'
    else
      redirect '/login'
    end
  end

  post '/inspections' do
    #make a new object
  end
end
