class InspectionController < ApplicationController


  get '/inspections/new' do
    check_logged_in
    #this pseudo redirect brings the user to a page to select the element
    @elements = Element.all
    erb :'/inspections/new_select_element'
  end

  # this is the "real" /inspections/new, the upper one lets the user select an element
  # which populates the new form with the rope names
  get '/inspections/new/:element_slug' do
    check_logged_in

    @element = Element.find_by_slug(params[:element_slug])
    erb :'/inspections/new'
  end

  post '/inspections' do
    details = params[:inspection]
    inspection = Inspection.create(climb_date:details[:climb_date], comments:details[:comments])

    #create a Climb object for each rope that was used, associating it with the rope
    details[:climbs].each do |rope_id, climb_num|
      climb_num = 0 if climb_num == nil
      inspection.climbs << Climb.create(number_of_climbs:climb_num, rope_id:rope_id, inspection_id:inspection.id)
    end

    inspection.element = Element.find_by_slug(params[:element])
    inspection.user = current_user

    #attempt to save, the date validation runs here
    if inspection.save
      flash[:type] = "success"
      flash[:message] = ["Inspection logged successfully"]

      redirect "/inspections/new/#{params[:element]}"
    else
      #redirect back to the 'new' page with an error
      flash[:type] = "error"
      flash[:message] = []
      inspection.errors.messages.each do |attr, error_message|
        flash[:message] << error_message[0]
      end

      redirect "/inspections/new/#{params[:element]}"
    end
  end

  get '/inspections/:id/edit' do
    #check if the user is the owner of the inspection
    if current_user == Inspection.find(params[:id]).user
      @inspection = Inspection.find(params[:id])
      erb :'/inspections/edit'
    else
      flash[:type] = "error"
      flash[:message] = "You must be signed in as that inspections' creator to view edit it"
      redirect '/'
    end
  end

  patch '/inspections/:id' do
    inspection = Inspection.find(params[:id])
    details = params[:inspection]
    inspection.update(climb_date:details[:climb_date], comments:details[:comments])

# TODO fix if they try to remove the date

    #update the climbs
    details[:climbs].each do |rope_id, climb_num|
      climb = inspection.climbs.detect {|climb| climb.rope_id = rope_id}
      climb_num = 0 if climb_num == nil
      climb.update(number_of_climbs:climb_num)
    end

    flash[:type] = "success"
    flash[:message] = ["Inspection successfully edited"]

    redirect "users/#{current_user.id}"
  end

  delete '/inspections/:id' do
    inspection = Inspection.find(params[:id])
    #destroy each climb associated with the inspection before destroying itself
    inspection.climbs.each do |climb|
      climb.destroy
    end
    inspection.destroy

    flash[:type] = "success"
    flash[:message] = ["Inspection successfully deleted"]

    redirect "/users/#{current_user.id}"
  end
end
