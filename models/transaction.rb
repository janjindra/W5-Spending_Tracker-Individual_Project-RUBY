require_relative('../db/sql_runner')

class Transaction

attr_accessor(:id, :merchant_id, :tag_id, :amount)

def initialize(db_hash)
  @id = db_hash['id'].to_i if db_hash['id']
  @merchant_id = db_hash['merchant_id'].to_i
  @tag_id = db_hash['tag_id'].to_i
  @amount = db_hash['amount'].to_f
end

#CRUD
def save()
  sql = "INSERT INTO transactions (merchant_id, tag_id, amount) VALUES ($1, $2, $3) RETURNING id"
  values = [@merchant_id, @tag_id, @amount]
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
  sql = "UPDATE transations SET (merchant_id, tag_id, amount) = ( $1, $2, $3 ) WHERE id = $4"
    values = [@merchant_id, @tag_id, @amount, @id]
    SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM transactions
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end
#Methods

def Transaction.full_details
  sql = "SELECT m.name, m.id, m.active, tr.id, tr.merchant_id, tr.tag_id, tr.amount, ta.id, ta.label, ta.active, m.logo FROM transactions tr
  INNER JOIN merchants m ON m.id=tr.merchant_id
  INNER JOIN tags ta ON ta.id=tr.tag_id"
full_details = SqlRunner.run(sql)
return full_details.map{|detail| detail}
end




end
