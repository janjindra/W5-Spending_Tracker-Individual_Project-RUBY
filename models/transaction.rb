require_relative('../db/sql_runner')
require('time')
require( 'pry-byebug' )

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

  #OTHER METHODS

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

  #All time totals
  def Transaction.total()
    sql = "SELECT sum(amount)
    FROM transactions"
    total = SqlRunner.run(sql)
    return total.values.first.first.to_f.round(2)
  end

  #Total for year & month combo
  def Transaction.total_by_yearmonth(year, month)
    sql = "SELECT sum(amount), EXTRACT(MONTH FROM time) as month, EXTRACT(YEAR FROM time) as year
    FROM transactions
    WHERE EXTRACT(YEAR FROM time)= $1 AND EXTRACT(MONTH FROM time)= $2
    GROUP BY year, month"
    values = [year, month]
    total_by_yearmonth = SqlRunner.run(sql,values)
    return total_by_yearmonth.map{|tr| tr}.first['sum'].to_f.round(2)
  end

  #Total by tag (spending category)
  def Transaction.total_by_tag(label)
    sql = "SELECT sum(transactions.amount)
    FROM transactions
    INNER JOIN tags ON tags.id=transactions.tag_id
    WHERE tags.label = $1"
    values = [label]
    total_by_tag = SqlRunner.run(sql,values)
    return total_by_tag.map{|tr| tr}.first['sum'].to_f.round(2)
  end

  #Total spending within a range (user selection of the range)
  def Transaction.total_by_range(from, to)
    sql = "SELECT * FROM transactions"
    transactions_array = SqlRunner.run(sql)
    array_sum =[]
    for hash in transactions_array
      transaction_timing  = Time.parse(hash['time'])
      from_timestamp  = Time.parse(from)
      to_timestamp  = Time.parse(to)
      if (transaction_timing <= to_timestamp &&
        transaction_timing >= to_timestamp)
        array_sum.push(hash['amount'].to_i)

      end
    end
    return array_sum.sum
  end


  #User budget is the sum of user's monthly budgets by across all spending categories
  def Transaction.user_budget()
    sql = "SELECT (budget_groceries+budget_shopping+budget_restaurants+budget_transport+
    budget_entertainment+budget_health+budget_services+budget_utilities+budget_rent) as budget
    FROM users
    WHERE id = 1" ###Hardcoded for the scope of this project
    result = SqlRunner.run( sql )
    return result.values.first.first.to_f.round(2)
  end



  #This message uses total by year-month combo
  def Transaction.budget_message(year, month)
    balance = (Transaction.user_budget() - Transaction.total_by_yearmonth(year,month)).round(2)
    if balance < 100 && balance > 0
      return "WARNING! You are nearing your monthly budget. You have £#{balance.abs} left to spend!"
    elsif balance > 0
      return "COOL! You have £#{balance} left to spend!"
    elsif balance == 0
      return "You've just used up all your budget!"
    else
      return "WARNING! You are £#{balance.abs} over your budget."
    end
  end

# PSEUDOCODE
# function budget_message (year (integer), month (integer))
  # calculate_balance = ( users budget ) - ( total spend by month )
  # round the balance to 2 decimal places
  # if calculate_balance > 0 and < 100
    # print "WARNING! You are nearing your monthly budget."
  # elsif calculate_balance > 0
    # print "COOL! You have £#{calculate_balance} left to spend!"
  # elsif calculate_balance == 0
    # print "You've just used up all your budget!"
  # else
    # print "WARNING! You are £#{calculate_balance} over your budget"
  # end
# end



  #This message uses total by tag
  def Transaction.budget_message_tag(label)
    balance = (Transaction.user_budget() - Transaction.total_by_tag(label)).round(2)
    if balance < 100 && balance > 0
      return "WARNING! You are nearing your monthly budget. You have £#{balance.abs} left to spend!"
    elsif balance > 0
      return "COOL! You still have £#{balance} to spend!"
    elsif balance == 0
      return "You've just used up all your budget!"
    else
      return "WARNING! You are £#{balance.abs} over your budget"
    end
  end

  #Analytics - list of all transactions by time with full details
  def Transaction.transactions_ordered_by_time()
    sql = "SELECT u.name as user_name, m.name as merchant_name,
    tr.amount, ta.label, tr.time as time,
    to_char(tr.time,'Month') as month_name,
    EXTRACT(MONTH FROM tr.time) as month_num,
    EXTRACT(YEAR FROM tr.time) as year_num,
    m.logo as m_logo, ta.logo as t_logo
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

  #All transactions for a given year & month combo
  def Transaction.find_month_num(year_num, month_num)
    sql = "SELECT u.name as user_name, m.name as merchant_name,
    tr.amount, ta.label, tr.time as time,
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
  end

  #All transactions for a given label (tag)
  def Transaction.find_tag(label)
    sql = "SELECT u.name as user_name, m.name as merchant_name,
    tr.amount, ta.label, tr.time as time, m.logo as m_logo,
    ta.logo as t_logo
    FROM transactions tr
    INNER JOIN merchants m ON m.id=tr.merchant_id
    INNER JOIN tags ta ON ta.id=tr.tag_id
    INNER JOIN users u ON u.id=tr.user_id
    WHERE ta.label = $1"
    values = [label]
    trans = SqlRunner.run( sql, values )
    return trans.map{|tr| tr}
  end

  #All transactions created within a time range selected by the user.
  def Transaction.time(date1, date2)
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run( sql)
    arr =[]
    for transaction in transactions
      transaction_time  = Time.parse(transaction['time']) #Time.parse(transaction.time)
      date1_date  = Time.parse(date1)
      date2_date  = Time.parse(date2)
      if transaction_time >= date1_date && transaction_time <= date2_date
        arr.push(transaction)
      end
    end
    return arr.map{|transaction| Transaction.new(transaction)}
  end

end
