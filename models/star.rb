class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM stars"
    results = SqlRunner.run(sql)
    return results.map { |star| Star.new(star) }
  end

  def save()
    sql = "INSERT INTO stars (
    first_name, last_name
  )
  VALUES (
    $1, $2
  )
  RETURNING id
  "
  values = [@first_name, @last_name]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def movies
  sql = "SELECT movies.*
  FROM movies
  INNER JOIN castings
  ON movies.id = castings.movie_id
  INNER JOIN stars
  ON stars.id = castings.star_id
  WHERE stars.id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return results.map { |movie| Movie.new(movie) }
end



end
