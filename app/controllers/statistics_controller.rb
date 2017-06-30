class StatisticsController < ApplicationController
  def index
    @actors = Actor.all
    @movies = Movie.all
    @genres = Genre.all
  end
end
