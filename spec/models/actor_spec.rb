require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'associations' do
    it 'has_many movies' do
      genre = Genre.new(name: 'test')
      actor = Actor.new(first_name: 'Bob', last_name: 'Rails')
      movie1 = actor.movies.new(name: 'tests', genre: genre)
      movie2 = Movie.new(name: 'rspec', genre: genre)
      actor.movies << movie2

      expect(actor.movies).to include(movie1, movie2)
    end
  end

  describe '#full_name' do
    it 'returns full name of actor' do
      actor = Actor.new(first_name: 'Bob', last_name: 'Rails')

      expect(actor.full_name).to eq 'Bob Rails'
    end
  end
end
