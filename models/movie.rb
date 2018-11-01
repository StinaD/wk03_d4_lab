require_relative("../db/sql_runner.rb")

class Movie

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
    @budget = options["budget"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM movies"
    results = SqlRunner.run(sql)
    return results.map { |movie| Movie.new(movie) }
  end

  def save()
    sql = "INSERT INTO movies (
    title, genre, budget
    )
    VALUES (
      $1, $2, $3
    )
    RETURNING id
    "
    values = [@title, @genre, @budget]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def stars
    sql = "SELECT stars.*
    FROM stars
    INNER JOIN castings
    ON stars.id = castings.star_id
    INNER JOIN movies
    ON movies.id = castings.movie_id
    WHERE movies.title = $1;"
    values = [@title]
    results = SqlRunner.run(sql, values)
    return results.map { |star| Star.new(star) }
  end

  def budget_remaining
    sql = "SELECT castings.*
    FROM castings
    INNER JOIN movies
    ON movies.id = castings.movie_id
    WHERE movies.title = $1;"
    values = [@title]
    results = SqlRunner.run(sql, values)
    castings = results.map { |casting| Casting.new(casting) }
    return @budget - ( castings.reduce(0) { | sum, casting |
    sum + casting.fee} )
  end

end
