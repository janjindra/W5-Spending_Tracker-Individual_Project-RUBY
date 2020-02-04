require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/user.rb' )
also_reload( '../models/*' )

get '/tags' do
  @tags = Tag.all
  erb (:"tags/index")
end


#Displays a Merchant form to submit a new Merchant
get '/tags/new' do
  @tags = Tag.all
  erb(:"tags/new")
end

#Saves a new transaction to the DB
post '/tags' do
  tag = Tag.new(params)
  tag.save
  redirect to("/tags")
end


#EDIT
get '/tags/:id/edit' do
  @tag = Tag.find(params[:id])
  @tags = Tag.all
  erb(:"tags/edit")
end

post '/tags/:id' do
@tag = Tag.new(params)  #??????
@tag.update()
redirect to("/tags")
end

#DELETE

post '/tags/:id/delete' do
@tag = Tag.find(params[:id])
@tag.delete()
redirect to("/tags")
end
