require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/user.rb' )
also_reload( '../models/*' )

get '/users' do
  @user = User.all
  erb (:"users/index")
end

#Creation of new users DISABLED for the scope of this project.
# get '/users/new' do
#   @tags = User.all
#   erb(:"user/new")
# end
#
# post '/users' do
#   user = User.new(params)
#   user.save
#   redirect to("/users")
# end

#EDIT
get '/users/:id/edit' do
  @user = User.find(params[:id])
  # @user = User.all
  erb(:"users/edit")
end

post '/users/:id' do
@user = User.new(params)
@user.update()
redirect to("/users")
end

#Deletion of users DISABLED for the scope of this project.
# post '/users/:id/delete' do
# @user = User.find(params[:id])
# @user.delete()
# redirect to("/users")
# end
