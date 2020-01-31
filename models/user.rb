require_relative('../db/sql_runner.rb')

class User

attr_accessor(:id, :name, :budget)

  def initialize (db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @name = db_hash['name']
    @budget = db_hash['budget']
  end


end
