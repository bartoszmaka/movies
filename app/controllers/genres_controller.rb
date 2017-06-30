class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save?
      redirect_to @genre
    else
      render 'new'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.update(params[:id], genre_params)
    if
      redirect_to @genre
    else
      render 'edit'
    end
  end

  def delete
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
