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

    binding.pry
    details = params[:inspection]
    inspection = Inspection.new(climb_date:details[:climb_date], comments:details[:comments])

    details[:climbs][0].each do |rope_id, climb_num|
      rope = Rope.find(rope_id)
      inspection.ropes << rope
      rope.log_climbs(climb_num)
      # figure out how to persist this info on the inspection object
    end

    inspection.element = Element.find_by_slug(params[:element])

    inspection.user = current_user
    inspection.save
    # make flash message about the inspection just made
    redirect "/inspections/new/#{params[:element]}"
  end
end
