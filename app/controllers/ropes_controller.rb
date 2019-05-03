class RopesController < ApplicationController
  # this route looks like a patch, but it actually "deletes" the rope,
  # but persists its data so a future admin can still access
  # retired ropes
  patch '/ropes/:id' do
    check_logged_in

    rope = Rope.find(params[:id])
    # grab on to the element for creating a new rope
    # and dissasociate this rope from the element
    session[:element] = rope.element
    rope.update(element:nil)

    redirect '/ropes/new'
  end

  get '/ropes/new' do
    check_logged_in

    erb :'/ropes/new'
  end

  post '/ropes' do
    rope = Rope.new
    rope.element = session[:element]
    rope.primary_color = params[:primary_color].downcase
    rope.pcord_color = params[:pcord_color]

    if rope.save
      # if successful, forget the element and move on
      session[:element] = nil

      flash[:type] = "success"
      flash[:message] = ["Rope created successfully"]
      redirect '/elements'
    else
      flash[:type] = "error"
      flash[:message] = []
      rope.errors.messages.each do |attr, error_message|
        flash[:message] << error_message[0]
      end

      redirect '/ropes/new'
    end
  end
end
