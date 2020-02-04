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
  #@transactions_by_time = Transaction.transactions_ordered_by_time
  # @budget = Transaction.user_budget
  # @message = Transaction.budget_message
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
@transaction = Transaction.new(params)  #??????
@transaction.update()
redirect to("/transactions")
# erb(:"transactions/update")
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
  # @year_names=Transaction.distinct_years
  @total = Transaction.total
  @yearmonths=Transaction.distinct_yearmonths
  erb(:"transactions/analytics")
end

#### ***** TO BE DELETED ****** ###########
#ANALYTICS - order by time:
get '/transactions/analytics/month' do
  @transactions_by_time = Transaction.transactions_ordered_by_time
  # @month_names=Transaction.distinct_months
  # @month_nums=Transaction.distinct_months_num
  erb(:"transactions/analytics-month")
end

#ANALYTICS - filter month
get '/transactions/analytics/month/:year/:month/table' do
  @transaction = Transaction.find_month_num(params[:year],params[:month])
  @transactions_by_time = Transaction.transactions_ordered_by_time
  # @month_names=Transaction.distinct_months
  # @year_names=Transaction.distinct_years
  @yearmonths=Transaction.distinct_yearmonths
  @total = Transaction.total
  @total_by_month = Transaction.total_by_month(params[:month])
  @budget = Transaction.user_budget
  @message = Transaction.budget_message(params[:month])
  @tags = Tag.all
  erb(:"transactions/analytics-m-table")
end

#ANALYTICS - all transaction by time, newest first.
get '/transactions/analytics/allbytime' do
  @transactions_by_time = Transaction.transactions_ordered_by_time
  # @month_names=Transaction.distinct_months
  @total = Transaction.total
  # @budget = Transaction.user_budget
  # @message = Transaction.budget_message(params[:month])
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
  erb(:"transactions/range")
end

#ANALYTICS - all transaction by tag (category)
get '/transactions/analytics/tag/:label/table' do
  @transactions_by_tag = Transaction.find_tag(params[:label])
  @total_by_tag = Transaction.total_by_tag(params[:label])
  @budget = Transaction.user_budget
  @message = Transaction.budget_message_tag(params[:label])
  @tags = Tag.all
  @yearmonths=Transaction.distinct_yearmonths
  @total = Transaction.total
  erb(:"transactions/analytics-t-table")
end
