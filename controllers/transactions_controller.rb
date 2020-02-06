require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require('time')
require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/user.rb' )
also_reload( '../models/*' )

#Displays all transaction details
get '/transactions' do
  @transactions = Transaction.all
  @total = Transaction.total
  erb (:"transactions/index")
end

#Displays a Transaction form to submit a new transaction
get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  @transactions = Transaction.all
  erb(:"transactions/new")
end

#Saves a new transaction to the DB
post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to("/transactions")
end


#EDIT
get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id])
  @tags = Tag.all
  @merchants = Merchant.all
  @transactions = Transaction.all
  erb(:"transactions/edit")
end

post '/transactions/:id' do
@transaction = Transaction.new(params)
@transaction.update()
redirect to("/transactions")
end

#DELETE:
post '/transactions/:id/delete' do
@transaction = Transaction.find(params[:id])
@transaction.delete()
redirect to("/transactions")
end


get '/transactions/analytics' do
  @transactions_by_time = Transaction.transactions_ordered_by_time
  @month_names=Transaction.distinct_months
  @tags = Tag.all
  @total = Transaction.total
  @yearmonths=Transaction.distinct_yearmonths
  erb(:"transactions/analytics")
end

#ANALYTICS - filter month
get '/transactions/analytics/month/:year/:month/table' do
  @transaction = Transaction.find_month_num(params[:year],params[:month])
  @transactions_by_time = Transaction.transactions_ordered_by_time
  @yearmonths=Transaction.distinct_yearmonths
  @total = Transaction.total
  @total_by_yearmonth = Transaction.total_by_yearmonth(params[:year],params[:month])
  @budget = Transaction.user_budget
  @message = Transaction.budget_message(params[:year],params[:month])
  @tags = Tag.all
  erb(:"transactions/analytics-m-table")
end

#ANALYTICS - all transaction by time, newest first.
get '/transactions/analytics/allbytime' do
  @transactions_by_time = Transaction.transactions_ordered_by_time
  @total = Transaction.total
  @yearmonths=Transaction.distinct_yearmonths
  @tags = Tag.all
  erb(:"transactions/analytics-bytime")
end

#ANALYTICS - all transactions within a specified time range.
post '/transactions/analytics/range' do
  @trans_per_range = Transaction.time(params[:date1], params[:date2])
  @tags = Tag.all
  @merchants = Merchant.all
  @yearmonths=Transaction.distinct_yearmonths
  @budget = Transaction.user_budget
  @total_by_range = Transaction.total_by_range(params[:date1], params[:date2])
  erb(:"transactions/analytics-range")
end

#ANALYTICS - all transaction by tag (category)
get '/transactions/analytics/tag/:label/table' do
  @transactions_by_tag = Transaction.find_tag(params[:label])
  @total_by_tag = Transaction.total_by_tag(params[:label])
  @budget = Transaction.user_budget #monthly budget across all categories
  @tag_budget = User.all #monthly budget per tag (category)
  @message = Transaction.budget_message_tag(params[:label])
  @tags = Tag.all
  @yearmonths=Transaction.distinct_yearmonths
  @total = Transaction.total
  erb(:"transactions/analytics-t-table")
end
