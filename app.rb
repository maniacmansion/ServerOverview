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

before do
#	content_type :txt
#	@defeat = {rock: :scissors, paper: :rock, scissors: :paper}
#	@throws = @defeat.keys
	@rechners = ['LS1', 'LS2', 'LS3']
	@users = ['Lisa', 'Bart', 'Tim', 'Dude', 'Guest', 'Free']
	@change = "nobody"
  @name = "Free"
	#usage = {LS1:Free, LS2:Free, LS3:Free}
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


get '/' do
 haml :index
end
#post '/' do
#  @time 
#end

get '/jump/:machine' do
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
  redirect '/overview'
end



#get '/*' do
#  redirect '/'	
#end

get '/test' do
  haml :test
end


get '/dump' do
  @nameN = "dasdsd"
  haml :dump  
end

__END__
@@dump
%html
  %body
    %h1 Welcome
    %p say what the name: #{@nameN}