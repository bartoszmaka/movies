class Movie < ApplicationRecord
  has_many :actor_movies
  has_many :actors, through: :actor_movies
  belongs_to :genre, counter_cache: :movies_count
end
