class ActorsController < ApplicationController
  def index
    @actors = Actor.all
  end

  def show
    @actor = Actor.find(params[:id])
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)
    if @actor.save?
      redirect_to @actor
    else
      render 'new'
    end
  end

  def edit
    @actor = Actor.find(params[:id])
  end

  def update
    @actor = Actor.update(params[:id], actor_params)
    if
      redirect_to @actor
    else
      render 'edit'
    end
  end

  def delete
    @actor = Actor.find(params[:id])
    @actor.destroy
    redirect_to actors_path
  end

  private

  def actor_params
    params.require(:actor).permit(:first_name, :last_name)
  end
end
