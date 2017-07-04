require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it 'has many actors' do
      genre = Genre.create(name: 'test')
      movie = Movie.create(name: 'The RSpec', revenue: 100, genre: genre)
      actor1 = movie.actors.create(first_name: 'Bob', last_name: 'Rails')
      actor2 = Actor.create(first_name: 'Jim', last_name: 'Ruby')
      movie.actors << actor2

      expect(movie.actors).to include(actor1, actor2)
    end

    it 'belongs to genre' do
      genre = Genre.create(name: 'test')
      movie = Movie.create(name: 'The RSpec', genre: genre)

      expect(movie.genre).to eq genre
    end
  end

  describe 'validations' do
    it 'requires presence revenue' do
      movie = Movie.new(name: 'The RSpec', revenue: nil)

      expect(movie.valid?).to be false
    end

    it 'requires name to be unique case insensitive' do
      Movie.create(name: 'The RSpec', revenue: 123)
      movie = Movie.new(name: 'THE RSPEC', revenue: 123)

      expect(movie.valid?).to be false
    end
  end
end
