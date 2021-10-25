class Admins::GenresController < ApplicationController
 before_action :authenticate_admin!

  def index
   @genres = Genre.all
   @genre = Genre.new
  end

  def create
  @genre = Genre.new(genre_params)
   if @genre.save
    redirect_to admins_genres_path
   else
    flash[:waning] = "※ジャンル名を入力してください"
    redirect_to admins_genres_path
   end
  end

  def edit
   @genre = Genre.find(params[:id])
  end

  def update
   @genre = Genre.find(params[:id])
   if @genre.update(genre_params)
    redirect_to admins_genres_path
   else
    flash[:warning] = "※ジャンル名を入力してください"
    redirect_to edit_admins_genre_path
   end
  end

  private
  def genre_params
   params.require(:genre).permit(:name)
  end
end