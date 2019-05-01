class InspectionController < ApplicationController
  get '/inspections/new' do
    if logged_in?
      @elements = Element.all
      erb :'/inspections/new_select_element'
    else
      redirect '/login'
    end
  end

  get '/inspections/new/:element_slug' do
    if logged_in?
      @element = Element.find_by_slug(params[:element_slug])
      erb :'/inspections/new'
    else
      redirect 'login'
    end
  end

  post '/inspections' do
    #make a new object
  end
end
