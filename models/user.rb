require_relative('../db/sql_runner.rb')

class User

attr_accessor(:id, :name, :budget_groceries,
  :budget_shopping, :budget_restaurants,
  :budget_transport,
:budget_entertainment, :budget_health,
:budget_services, :budget_utilities, :budget_rent)

  def initialize (db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @name = db_hash['name']
    @budget_groceries = db_hash['budget_groceries'].to_f
    @budget_shopping = db_hash['budget_shopping'].to_f
    @budget_restaurants = db_hash['budget_restaurants'].to_f
    @budget_transport = db_hash['budget_transport'].to_f
    @budget_entertainment = db_hash['budget_entertainment'].to_f
    @budget_health = db_hash['budget_health'].to_f
    @budget_services = db_hash['budget_services'].to_f
    @budget_utilities = db_hash['budget_utilities'].to_f
    @budget_rent = db_hash['budget_rent'].to_f

  end

  #CRUD
  def save()
    sql = "INSERT INTO users (name, budget_groceries, budget_shopping, budget_restaurants, budget_transport,
  budget_entertainment,budget_health, budget_services, budget_utilities, budget_rent)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id"
    values = [@name, @budget_groceries, @budget_shopping, @budget_restaurants, @budget_transport,
  @budget_entertainment,@budget_health, @budget_services, @budget_utilities, @budget_rent]
    users_data = SqlRunner.run(sql, values)
    @id = users_data.first()['id'].to_i
  end

  def User.all()
    sql = "SELECT * FROM users"
    users_data = SqlRunner.run(sql)
    return users_data.map{|user| User.new(user)}
  end

  def User.delete_all
    sql = "DELETE * from users"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE users SET (name, budget_groceries, budget_shopping, budget_restaurants, budget_transport,
  budget_entertainment,budget_health, budget_services, budget_utilities, budget_rent)
  = ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
  WHERE id = $11"
    values = [@name, @budget_groceries, @budget_shopping, @budget_restaurants, @budget_transport,
  @budget_entertainment,@budget_health, @budget_services, @budget_utilities, @budget_rent, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

#Other Methods
def User.find( id )
sql = "SELECT * FROM users WHERE id = $1"
values = [id]
user = SqlRunner.run( sql, values )
result = User.new( user.first )
return result
end

def budget()
sql = "SELECT (budget_groceries+budget_shopping+budget_restaurants+budget_transport+
budget_entertainment+budget_health+budget_services+budget_utilities+budget_rent) as budget
FROM users
WHERE id = $1"
values = [@id]
budget = SqlRunner.run( sql, values )
return budget.first['budget'].to_i
end

end
