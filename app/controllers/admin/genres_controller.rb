class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_genre, only: [:edit, :update]
  before_action :genre_all

  def index
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save ? (redirect_to admin_genres_path) : (render :index)
  end

  def edit
  end

  def update
    @genre.update(genre_params) ? (redirect_to admin_genres_path) : (render :edit)
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def ensure_genre
    @genre = Genre.find(params[:id])
  end

  def genre_all
    @genres = Genre.all
  end

end
