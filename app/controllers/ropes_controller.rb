class RopesController < ApplicationController
  # this route looks like a patch, but it actually "deletes" the rope,
  # but persists its data so a future admin can still access
  # retired ropes
  patch '/ropes/:id' do
    check_logged_in

    rope = Rope.find(params[:id])
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
    rope.save

    session[:element] = nil

    flash[:type] = "success"
    flash[:message] = ["Rope created successfully"]
    redirect '/elements'
  end
end
