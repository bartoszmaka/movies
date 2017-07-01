class StatisticsController < ApplicationController
  def index
    @most_active_actor = Actor.order(movies_count: :desc).first
    @biggest_revenue_movie = Movie.order(revenue: :desc).first
    @most_popular_genre = Genre.order(movies_count: :desc).first
  end
end
