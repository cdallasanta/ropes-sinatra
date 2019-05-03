class InspectionController < ApplicationController
  get '/inspections/new' do
    check_logged_in

    @elements = Element.all
    erb :'/inspections/new_select_element'

  end

  get '/inspections/new/:element_slug' do
    check_logged_in

    @element = Element.find_by_slug(params[:element_slug])
    erb :'/inspections/new'
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
    # TODO make flash message about the inspection just created
    redirect "/inspections/new/#{params[:element]}"
  end

  get '/inspections/:id/edit' do
    if current_user == Inspection.find(params[:id]).user
      @inspection = Inspection.find(params[:id])
      erb :'/inspections/edit'
    else
      #TODO error message
      redirect '/'
    end
  end

  patch '/inspections/:id' do
    inspection = Inspection.find(params[:id])
    details = params[:inspection]
    inspection.update(climb_date:details[:climb_date], comments:details[:comments])

    #update the climbs
    details[:climbs].each do |rope_id, climb_num|
      climb = inspection.climbs.detect {|climb| climb.rope_id = rope_id}
      climb.update(number_of_climbs:climb_num)
    end

    redirect "users/#{current_user.id}"
  end

  delete '/inspections/:id' do
    inspection = Inspection.find(params[:id])
    inspection.climbs.each do |climb|
      climb.destroy
    end
    inspection.destroy

    redirect "/users/#{current_user.id}"
  end
end
