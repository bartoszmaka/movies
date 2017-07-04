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

  describe 'validations' do
    it 'requires presence of first_name' do
      actor = Actor.new(first_name: '', last_name: 'Rails')

      expect(actor.valid?).to be false
    end

    it 'requires presence of last_name' do
      actor = Actor.new(first_name: 'Bob', last_name: '')

      expect(actor.valid?).to be false
    end

    it 'requires first_name last_name combination to be unique' do
      Actor.create(first_name: 'Bob', last_name: 'Rails')
      actor1 = Actor.new(first_name: 'Bob', last_name: 'Rails')
      actor2 = Actor.new(first_name: 'Jim', last_name: 'Rails')

      expect(actor1.valid?).to be false
      expect(actor2.valid?).to be true
    end
  end

  describe '#full_name' do
    it 'returns full name of actor' do
      actor = Actor.new(first_name: 'Bob', last_name: 'Rails')

      expect(actor.full_name).to eq 'Bob Rails'
    end
  end
end
