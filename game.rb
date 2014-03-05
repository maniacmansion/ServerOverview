require 'sinatra'
#Sinatra framework requirement

#array of valid moves which can be performed by man or machine
before do
	content_type :txt
	@defeat = {rock: :scissors, paper: :rock, scissors: :paper}
	@throws = @defeat.keys
end

get '/throw/:type' do
	player_throw = params[:type].to_sym
	#the param [] has stores querystrings and from data
	
	#in case does an unvalid throw
	if !@throws.include?(player_throw)
		halt 403, "You must throw one of the following: #{@throws}"
	end

	#this is the computer throw
	computer_throw = @throws.sample
	
	#compare mans versus computers throw
	if player_throw == computer_throw
		"Draw. Try again!"
	elsif computer_throw == @defeat[player_throw]
		"Flawless Victory!; #{player_throw} beats #{computer_throw}!"
	else "Ouch! #{computer_throw} beats #{player_throw}"
	end
end
