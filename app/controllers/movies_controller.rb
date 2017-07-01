class MoviesController < ApplicationController
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
    @actors = Actor.all
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.actor_ids = params[:actors]
    if @movie.save
      redirect_to @movie
    else
      @actors = Actor.all
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
    @actors = Actor.all
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to @movie
    else
      @actors = Actor.all
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :revenue, :genre_name)
  end
end
