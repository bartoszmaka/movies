g1 = Genre.create(name: 'comedy')
g2 = Genre.create(name: 'drama')
g3 = Genre.create(name: 'science fiction')
g4 = Genre.create(name: 'thriller')

genres = [g1, g2, g3, g4]
words = %w[the cheese comeback big space angry]
names = %w[RSpec Bob Jim Rails Ementaler George]

10.times do
  Actor.find_or_create_by(first_name: names.sample, last_name: names.sample)
  Movie.find_or_create_by(name: words.sample(2).join(' '),
                          revenue: rand * 100_000,
                          genre_id: genres.sample.id)
end

Movie.all.each do |movie|
  4.times do
    a = Actor.all.sample
    movie.actors << a unless movie.actors.include? a
  end
end



