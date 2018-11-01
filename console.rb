require('pry')
require_relative('models/casting')
require_relative('models/movie')
require_relative('models/star')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({"first_name" => "Tom", "last_name" => "Cruise"})
star1.save
star2 = Star.new({"first_name" => "Emma", "last_name" => "Stone"})
star2.save
star3 = Star.new({"first_name" => "Ryan", "last_name" => "Gosling"})
star3.save

movie1 = Movie.new({"title" => "La La Land", "genre" => "musical", "budget" => "100"})
movie1.save
movie2 = Movie.new({"title" => "Mission Impossible", "genre" => "action", "budget" => "80"})
movie2.save
#
casting1 = Casting.new({"movie_id" => movie1.id, "star_id" => star2.id, "fee" => "20"})
casting1.save
casting2 = Casting.new({"movie_id" => movie2.id, "star_id" => star1.id, "fee" => "22"})
casting2.save
casting3 = Casting.new({"movie_id" => movie1.id, "star_id" => star3.id, "fee" => "25"})
casting3.save

binding.pry
nil
