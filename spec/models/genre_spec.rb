require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'associations' do
    it 'has many movies' do
      genre = Genre.create(name: 'test')
      movie1 = genre.movies.create(name: 'The RSpec', revenue: 100)
      movie2 = Movie.create(name: 'The RSpec 2', revenue: 100 , genre: genre)

      expect(genre.movies).to include(movie1, movie2)
    end
  end
end
