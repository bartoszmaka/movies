class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  def full_name
    "#{first_name} #{last_name}"
  end

  def latest_movies
    movies.limit(3)
  end
end
