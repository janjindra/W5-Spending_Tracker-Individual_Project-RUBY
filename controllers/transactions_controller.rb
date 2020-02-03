require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/user.rb' )
also_reload( '../models/*' )

#Displays all transaction details
get '/transactions' do
  @transactions = Transaction.all
  @total = Transaction.total
  @budget = Transaction.user_budget
  @message = Transaction.budget_message
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
erb(:"transactions/update")
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
  erb(:"transactions/analytics")
end

#### ***** TO BE DELETED ****** ###########
#ANALYTICS - order by time:
get '/transactions/analytics/month' do
  @transactions_by_time = Transaction.transactions_ordered_by_time
  @month_names=Transaction.distinct_months
  @month_nums=Transaction.distinct_months_num
  erb(:"transactions/analytics-month")
end

#ANALYTICS - filter month
get '/transactions/analytics/month/:month/table' do
  @transaction = Transaction.find_month_num(params[:month])
  @transactions_by_time = Transaction.transactions_ordered_by_time
  @month_names=Transaction.distinct_months
  @month_nums=Transaction.distinct_months_num

  @total = Transaction.total
  @total_by_month = Transaction.total_by_month(params[:month])
  @budget = Transaction.user_budget
  @message = Transaction.budget_message
  erb(:"transactions/analytics-m-table")
end

get '/transactions/analytics/allbytime' do
  @transactions_by_time = Transaction.transactions_ordered_by_time
  @month_names=Transaction.distinct_months
  @total = Transaction.total
  @budget = Transaction.user_budget
  @message = Transaction.budget_message
  erb(:"transactions/analytics-bytime")
end

#===============================

# #Get transaction details for 1 specific transation ID:
# get '/transactions/:id/edit' do
#   @tags = Tag.all
#   @merchants = Merchant.all
#   #@transactions = Transaction.all
#   @transaction = Transaction.find_transation_by_id(params[:id])
#   #@tag = Tag.find_tag_by_id(params[:id])
#   #@merchant = Merchant.find_merchant_by_id(params[:id])
#   # @transaction = Transaction.full_details_by_id(params[:id])
#   erb(:"transactions/edit")
# end
#
# #Edits an existing transaction
# post '/transactions/:id' do
#   transaction = Transaction.new(params[:id].to_i)
#   transaction.save
#   erb(:"transactions/update")
# end
