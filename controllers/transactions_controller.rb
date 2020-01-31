require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/user.rb' )
also_reload( '../models/*' )

get '/transactions' do
  @transactions = Transaction.full_details
  erb (:"transactions/index")
end

get '/transactions/new' do
  @transactions = Transaction.all
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"transactions/new")
end

post '/transactions' do
  new_transaction = Transaction.new(params)
  new_transaction.save
  redirect to("/transactions")
end
