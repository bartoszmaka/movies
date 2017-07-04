require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'associations' do
    it 'has many movies' do
      genre = Genre.create(name: 'test')
      movie1 = genre.movies.create(name: 'The RSpec', revenue: 100)
      movie2 = Movie.create(name: 'The RSpec 2', revenue: 100, genre: genre)

      expect(genre.movies).to include(movie1, movie2)
    end
  end

  describe 'validations' do
    it 'requires presence of name' do
      genre = Genre.new(name: '')

      expect(genre.valid?).to be false
    end

    it 'requires name to be unique case insensitive' do
      Genre.create(name: 'RSpec')
      genre = Genre.new(name: 'RSPEC')

      expect(genre.valid?).to be false
    end
  end
end
