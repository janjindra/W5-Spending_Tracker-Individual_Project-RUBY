require_relative('../db/sql_runner.rb')

class User

attr_accessor(:id, :name, :budget)

  def initialize (db_hash)
    @id = 1
    @name = db_hash['name']
    @budget = db_hash['budget'].to_f
  end

  #CRUD
  def save()
    sql = "INSERT INTO users (id, name, budget)
    VALUES ($1, $2, $3) RETURNING *"
    values = [@id, @name, @budget]
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
    sql = "UPDATE users SET (id, name, budget) = ( $1, $2, $3) WHERE id = $4"
    values = [@id, @name, @budget]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

#Other Methods


end
