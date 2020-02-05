require_relative('../db/sql_runner')

class Tag

  attr_accessor(:label, :active, :logo)
  attr_reader(:id)

  def initialize(db_hash)
    @id = db_hash['id'].to_i if db_hash['id']
    @label = db_hash['label']
    @active = db_hash['active']
    @logo = db_hash['logo']
  end

  #CRUD
  def save()
    sql = "INSERT INTO tags (label, active, logo) VALUES ($1, $2, $3) RETURNING id"
    values = [@label, @active, @logo]
    tags_data = SqlRunner.run(sql, values)
    @id = tags_data.first()['id'].to_i
  end


  def Tag.all()
    sql = "SELECT * FROM tags"
    tags_data = SqlRunner.run(sql)
    return tags_data.map{|tag| Tag.new(tag)}
  end

  def Tag.delete_all
    sql = "DELETE * from tags"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE tags SET (label, active, logo) = ( $1, $2, $3 ) WHERE id = $4"
    values = [@label, @active, @logo, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #OTHER METHODS

  def Tag.find( id )
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    trans = SqlRunner.run( sql, values )
    result = Tag.new( trans.first )
    return result
  end



end
