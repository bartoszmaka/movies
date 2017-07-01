class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  validates :last_name, presence: true
  validates :first_name, presence: true,
                         uniqueness: { message: 'and last name combination already exists',
                                       scope: :last_name,
                                       case_sensitive: false }

  def full_name
    "#{first_name} #{last_name}"
  end

  def latest_movies
    movies.limit(3)
  end
end
