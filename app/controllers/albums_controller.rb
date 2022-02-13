class AlbumsController < ApplicationController
  def new
    if logged_in?
      @album = current_user.albums.build
    else
      flash[:warning] = 'You must be logged in to create a album'
      redirect_to '/login'
    end
  end

  def create
    puts 'estou na create -------------------'
    @album = current_user.albums.build(album_params)
    puts album_params
    if @album.save
      flash[:success] = 'Album has been created'
      redirect_to root_path
    else
      # atencao - se user o redirect nao vai funcionar as flash messages
      render '/albums/new'
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :artist, :year)
  end
end
