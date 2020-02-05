require_relative('../db/sql_runner.rb')

class Merchant

  attr_accessor(:name, :active, :logo)
  attr_reader(:id)

  def initialize (db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @name = db_hash['name']
    @active = db_hash['active']
    @logo = db_hash['logo']
  end


  #CRUD:
  def save()
    sql = "INSERT INTO merchants (name, active, logo)
    VALUES ($1, $2, $3) RETURNING id"
    values = [@name, @active, @logo]
    merchants_data = SqlRunner.run(sql, values)
    @id = merchants_data.first()['id'].to_i
  end

  def Merchant.all()
    sql = "SELECT * FROM merchants"
    merchants_data = SqlRunner.run(sql)
    return merchants_data.map{|merchant| Merchant.new(merchant)}
  end

  def Merchant.delete_all
    sql = "DELETE * from merchants"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE merchants SET (name, active, logo) = ( $1, $2, $3 ) WHERE id = $4"
    values = [@name, @active, @logo, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #OTHER METHODS:

  def Merchant.find( id )
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    trans = SqlRunner.run( sql, values )
    result = Merchant.new( trans.first )
    return result
  end

end
