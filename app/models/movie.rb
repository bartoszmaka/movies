class Movie < ApplicationRecord
  has_many :actor_movies
  has_many :actors, through: :actor_movies
  belongs_to :genre, counter_cache: :movies_count

  validates :revenue, presence: true
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  def genre_name
    genre&.name
  end

  def genre_name=(value)
    self.genre = Genre.find_or_create_by(name: value)
  end
end
