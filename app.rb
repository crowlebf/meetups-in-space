require 'sinatra'
require_relative 'config/application'
require 'pry'

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all.order("lower(name)")
  erb :'meetups/index'
end

get '/meetups/new' do
  if session[:user_id].nil?
    flash[:notice] = "You're not signed in"
    redirect '/meetups'
  end
  erb :'meetups/new'
end

post "/meetups" do
  while params["name"].strip.empty? || params["location"].strip.empty? || params["description"].strip.empty?
    flash[:notice] = "Please fill out all fields"
    redirect '/meetups/new'
  end
  current_user
  if Meetup.create(name: params["name"], location: params["location"], description: params["description"], creator: @current_user.id).valid?
    meetup = Meetup.create(name: params["name"], location: params["location"], description: params["description"], creator: @current_user.id)
    Membership.create(user: @current_user, meetup: meetup)
    redirect "/meetups"
  end
  flash[:notice] = "The meetup already exists"
  redirect '/meetups/new'
end

get '/meetups/:id' do
  if session[:user_id].nil?
    flash[:notice] = "You're not signed in"
    redirect '/meetups'
  end
  @meetup = Meetup.find(params["id"])
  @members = @meetup.users
  @creator_id = @meetup.creator
  @creator = User.find(@creator_id)
  erb :'meetups/show'
end

post "/meetups/:id" do
  current_user
  if Meetup.find(params["id"]).creator != session[:user_id]
    if Membership.create(user: @current_user, meetup_id: params["id"]).valid?
      Membership.create(user: @current_user, meetup_id: params["id"])
      redirect '/meetups/' + params["id"]
    else
      flash[:notice] = "You are already the creator of this meetup"
    end
  end
  flash[:notice] = "You have already joined this meetup"
  redirect '/meetups/' + params["id"]
end



