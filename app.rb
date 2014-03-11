require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'haml'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, 'sqlite3:///db/server.db'

class Server < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true
end

class User < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
end


before do
#	content_type :txt
#	@defeat = {rock: :scissors, paper: :rock, scissors: :paper}
#	@throws = @defeat.keys
	@rechners = ['LS1', 'LS2', 'LS3']
	#@users = ['Lisa', 'Bart', 'Tim', 'Dude', 'Guest', 'Free']
end

p = Server.find_by(title: "LS1")
if p == nil
  Server.create(title: "LS1", body: "Free")
  Server.create(title: "LS2", body: "Free")
  Server.create(title: "LS3", body: "Free")
else
  p.update(body: "Free")
  Server.find_by(title: "LS2").update(body: "Free")
  Server.find_by(title: "LS3").update(body: "Free")
end

q = User.find_by(name: "Free")
if q == nil
  User.create(name: "Free")
  User.create(name: "Guest")
else
end



get '/' do
  @servers = Server.all
  haml :index
end


get '/jump/:machine' do
  #if params[:machine] == Server.all(title)
  # Fehlerresistenz: :machine included in Server.all(title)
  haml :jump
end

post '/jump/:machine' do
  #if params[:machine] == Server.all(title)
  # Fehlerresistenz: :machine included in Server.all(title)
  @users = User.all
  haml :jump
end


get '/confirm/:user/:machine' do
  @nameN = params[:user]
  @machineN = params[:machine]
  @servertime = Time.now
  haml :confirm
end


get '/overview' do
  @servers = Server.all
  haml :overview 
end


post '/time/:machineN/:user' do
  ## p = Server.new(title: "#{params[:machineN]}", body: "#{params[:user]}")
  ## p.save
  p = Server.find_by(title: "#{params[:machineN]}")
  p.update(body: "#{params[:user]}")
  redirect '/'
end



#get '/*' do
#  redirect '/'	
#end

get '/test' do
  haml :test
end


get '/edit_user' do
  @users = User.all
  haml :edit_user
end

get '/edit_server' do
  @servers = Server.all
  haml :edit_server
end


__END__
@@dump
%html
  %body
    %h1 Welcome
    %p say what the name: #{@nameN}
