# frozen_string_literal: true

class AlbumsController < ApplicationController
  def new
    if logged_in?
      @album = current_user.albums.build
      @artist_list = %w[Artist1 Artist2 Artist3 Artist4]
    else
      flash[:warning] = 'You must be logged in to create a album'
      redirect_to '/login'
    end
  end

  def create
    @album = current_user.albums.build(album_params)
    puts album_params
    if @album.save
      flash[:success] = 'Album has been created'
      redirect_to albums_path
    else
      # atencao - se user o redirect nao vai funcionar as flash messages
      render '/albums/new'
    end
  end

  def index
    if logged_in?
      @albums = Album.all
    else
      flash[:warning] = 'You must be logged in to see the albums'
      redirect_to root_path
    end
  end

  def destroy
    album = Album.find_by(params[:id])
    album.destroy
    flash[:success] = 'Album deleted'
    redirect_to root_path
  end

  private

  def album_params
    params.require(:album).permit(:name, :artist, :year)
  end
end
