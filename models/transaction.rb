require_relative('../db/sql_runner')

class Transaction

  attr_accessor(:merchant_id, :tag_id, :amount, :user_id)
  attr_reader(:id)

  def initialize(db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @merchant_id = db_hash['merchant_id'].to_i
    @tag_id = db_hash['tag_id'].to_i
    @user_id = 1
    @amount = db_hash['amount'].to_f
  end

  #CRUD
  def save()
    sql = "INSERT INTO transactions (merchant_id, tag_id, user_id, amount)
    VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@merchant_id, @tag_id, @user_id, @amount]
    transactions_data = SqlRunner.run(sql, values)
    @id = transactions_data.first()['id'].to_i
  end

  def Transaction.all()
    sql = "SELECT * FROM transactions"
    transactions_data = SqlRunner.run(sql)
    return transactions_data.map{|transaction| Transaction.new(transaction)}
  end

  def Transaction.delete_all
    sql = "DELETE * from transactions"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE transactions SET (merchant_id, tag_id, user_id, amount)
    = ( $1, $2, $3, $4 ) WHERE id = $5"
    values = [@merchant_id, @tag_id, @user_id, @amount, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  #Other Methods

  def merchant()
      sql = "SELECT * FROM merchants
      WHERE id = $1"
      values = [@merchant_id]
      results = SqlRunner.run( sql, values )
      return Merchant.new( results.first )
    end

    def tag()
      sql = "SELECT * FROM tags
      WHERE id = $1"
      values = [@tag_id]
      results = SqlRunner.run( sql, values )
      return Tag.new( results.first )
    end


    def Transaction.find( id )
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    trans = SqlRunner.run( sql, values )
    result = Transaction.new( trans.first )
    return result
  end

def Transaction.total()
  sql = "SELECT sum(amount)
  FROM transactions"
  total = SqlRunner.run(sql)
  return total.values.first.first.to_f.round(2)
end

def Transaction.user_budget()
sql = "SELECT budget FROM users WHERE id = 1"
result = SqlRunner.run( sql )
return result.values.first.first.to_f.round(2)
end

def Transaction.budget_message()
  balance = (Transaction.user_budget() - Transaction.total()).round(2)
  if balance > 0
    return "COOL! You still have £#{balance} to spend!"
  elsif balance == 0
    return "You've just used up all your budget!"
  else
    return "WARNING! You are £#{balance.abs} over your budget"
end
end


  ##----------------

  # def Transaction.full_details
  #   sql = "SELECT m.name, m.id, m.active, tr.id as unique_id, tr.merchant_id, tr.tag_id, tr.amount, ta.id, ta.label, ta.active, m.logo FROM transactions tr
  #   INNER JOIN merchants m ON m.id=tr.merchant_id
  #   INNER JOIN tags ta ON ta.id=tr.tag_id"
  #   full_details = SqlRunner.run(sql)
  #   return full_details.map{|detail| detail}
  # end
  #
  # def Transaction.find_transation_by_id(id)
  #   sql = "SELECT * FROM transactions
  #   WHERE id = $1"
  #   values = [id]
  #   full_details_for_an_id = SqlRunner.run(sql, values)
  #   return Transaction.new(full_details_for_an_id.first)
  # end
  #
  # def Transaction.full_details_by_id(id)
  #   sql = "SELECT m.name, m.id, m.active, tr.id as unique_id, tr.merchant_id, tr.tag_id, tr.amount, ta.id, ta.label, ta.active, m.logo FROM transactions tr
  #   INNER JOIN merchants m ON m.id=tr.merchant_id
  #   INNER JOIN tags ta ON ta.id=tr.tag_id
  #   WHERE tr.id = $1"
  #   values = [id]
  #   full_details = SqlRunner.run(sql, values)
  #   return full_details.map{|detail| detail}
  # end

end
