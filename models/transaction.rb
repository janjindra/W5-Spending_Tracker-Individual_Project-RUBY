require_relative('../db/sql_runner')

class Transaction

  attr_accessor(:merchant_id, :tag_id, :amount, :user_id, :time)
  attr_reader(:id)

  def initialize(db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @merchant_id = db_hash['merchant_id'].to_i
    @tag_id = db_hash['tag_id'].to_i
    @user_id = 1
    @amount = db_hash['amount'].to_f
    @time = Time.now
    #TIME doc: https://www.tutorialspoint.com/ruby/ruby_date_time.htm
  end

  #CRUD
  def save()
    sql = "INSERT INTO transactions (merchant_id, tag_id, user_id, amount, time)
    VALUES ($1, $2, $3, $4, $5) RETURNING *"
    values = [@merchant_id, @tag_id, @user_id, @amount, @time]
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
    sql = "UPDATE transactions SET (merchant_id, tag_id, user_id, amount, time)
    = ( $1, $2, $3, $4, $5 ) WHERE id = $6"
    values = [@merchant_id, @tag_id, @user_id, @amount, @time, @id]
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

  def Transaction.total_by_month(month_num)
    sql = "SELECT sum(amount), EXTRACT(MONTH FROM time) as month
    FROM transactions
    WHERE EXTRACT(MONTH FROM time)= $1
    GROUP BY month"
    values = [month_num]
    total_by_month = SqlRunner.run(sql,values)
    return total_by_month.map{|tr| tr}.first['sum'].to_f.round(2)
  end


  def Transaction.find_month_num(month_num)
    sql = "SELECT u.name as user_name, m.name as merchant_name,
    tr.amount,
    ta.label,
    tr.time as time,
    to_char(tr.time,'Month') as month_name,
    EXTRACT(MONTH FROM tr.time) as month_num,
    m.logo as m_logo,
    ta.logo as t_logo
     FROM transactions tr
      INNER JOIN merchants m ON m.id=tr.merchant_id
      INNER JOIN tags ta ON ta.id=tr.tag_id
      INNER JOIN users u ON u.id=tr.user_id
    WHERE EXTRACT(MONTH FROM tr.time)= $1"
    values = [month_num]
    trans = SqlRunner.run( sql, values )
    return trans.map{|tr| tr}
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

  #Analytics
def Transaction.transactions_ordered_by_time()
  sql = "SELECT u.name as user_name, m.name as merchant_name,
  tr.amount,
  ta.label,
  tr.time as time,
  to_char(tr.time,'Month') as month_name,
  EXTRACT(MONTH FROM tr.time) as month_num,
  EXTRACT(YEAR FROM tr.time) as year_num,
  m.logo as m_logo,
  ta.logo as t_logo
  FROM transactions tr
    INNER JOIN merchants m ON m.id=tr.merchant_id
    INNER JOIN tags ta ON ta.id=tr.tag_id
    INNER JOIN users u ON u.id=tr.user_id
    ORDER BY tr.time desc, m.name, ta.label, tr.amount"
    transactions_ordered_by_time_list = SqlRunner.run(sql)
    return transactions_ordered_by_time_list.map{|tr| tr}
  end

def Transaction.distinct_months #names
  distinct_months = []
  array_of_all_transactions = Transaction.transactions_ordered_by_time()
  for hash in array_of_all_transactions
    if distinct_months.include?(hash['month_name'].strip) == false
      distinct_months.push(hash['month_name'].strip)
    end
  end
  return distinct_months
end

def Transaction.distinct_months_num #numbers
  distinct_months_num = []
  array_of_all_transactions = Transaction.transactions_ordered_by_time()
  for hash in array_of_all_transactions
    if distinct_months_num.include?(hash['month_num'].strip) == false
      distinct_months_num.push(hash['month_num'].strip)
    end
  end
  return distinct_months_num
end

def Transaction.distinct_years
  distinct_years = []
  array_of_all_transactions = Transaction.transactions_ordered_by_time()
  for hash in array_of_all_transactions
    if distinct_years.include?(hash['year_num'].strip) == false
      distinct_years.push(hash['year_num'].strip)
    end
  end
  return distinct_years
end

def Transaction.distinct_yearmonths
  distinct_yearmonths = []
  array_of_all_transactions = Transaction.transactions_ordered_by_time()
  for hash in array_of_all_transactions
    if distinct_yearmonths.include?(hash['year_num'].strip+"/"+hash['month_num'].strip) == false
      distinct_yearmonths.push(hash['year_num'].strip+"/"+hash['month_num'].strip)
    end
  end
  return distinct_yearmonths
end


def Transaction.find_month_num(year_num, month_num)
  sql = "SELECT u.name as user_name, m.name as merchant_name,
  tr.amount,
  ta.label,
  tr.time as time,
  to_char(tr.time,'Month') as month_name,
  EXTRACT(MONTH FROM tr.time) as month_num,
  EXTRACT(YEAR FROM tr.time) as year_num,
  m.logo as m_logo,
  ta.logo as t_logo
   FROM transactions tr
    INNER JOIN merchants m ON m.id=tr.merchant_id
    INNER JOIN tags ta ON ta.id=tr.tag_id
    INNER JOIN users u ON u.id=tr.user_id
  WHERE (EXTRACT(YEAR FROM tr.time)= $1 AND EXTRACT(MONTH FROM tr.time)= $2)"
  values = [year_num, month_num]
  trans = SqlRunner.run( sql, values )
  return trans.map{|tr| tr}
  # result = Transaction.new( trans.first )
  # return result
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
