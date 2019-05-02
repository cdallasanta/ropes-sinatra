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

    details = params[:inspection]
    inspection = Inspection.create(climb_date:details[:climb_date], comments:details[:comments])

    details[:climbs].each do |rope_id, climb_num|
      inspection.climbs << Climb.create(number_of_climbs:climb_num, rope_id:rope_id, inspection_id:inspection.id)
    end

    inspection.element = Element.find_by_slug(params[:element])
    inspection.user = current_user
    inspection.save
    # make flash message about the inspection just created
    redirect "/inspections/new/#{params[:element]}"
  end
end
