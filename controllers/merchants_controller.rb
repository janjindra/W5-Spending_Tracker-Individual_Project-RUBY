require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/user.rb' )
also_reload( '../models/*' )

get '/merchants' do
  @merchants = Merchant.all
  erb (:"merchants/index")
end

#Displays a Merchant form to submit a new Merchant
get '/merchants/new' do
  # @tags = Tag.all
  @merchants = Merchant.all
  # @transactions = Transaction.all
  erb(:"merchants/new")
end

#Saves a new transaction to the DB
post '/merchants' do
  merch = Merchant.new(params)
  merch.save
  redirect to("/merchants")
end


#EDIT
get '/merchants/:id/edit' do
  @merchant = Merchant.find(params[:id])
  # @tags = Tag.all
  @merchants = Merchant.all
  # @transactions = Transaction.all
  erb(:"merchants/edit")
end

post '/merchants/:id' do
@merchant = Merchant.new(params)  #??????
@merchant.update()
erb(:"merchants/update")
end

#DELETE

post '/merchants/:id/delete' do
@merchant = Merchant.find(params[:id])
@merchant.delete()
redirect to("/merchants")
end
