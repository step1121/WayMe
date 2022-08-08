class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_genre, only: [:edit, :update]
  
  def index
      @genre = Genre.new
      @genres = Genre.all
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end
  
  def edit
    @genres = Genre.all
  end
  
  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end
  
  
  private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
  def ensure_genre
    @genre = Genre.find(params[:id])
  end
end
