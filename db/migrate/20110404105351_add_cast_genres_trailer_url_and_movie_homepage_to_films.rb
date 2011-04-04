class AddCastGenresTrailerUrlAndMovieHomepageToFilms < ActiveRecord::Migration
  def self.up
    add_column :films, :cast, :text
    add_column :films, :genres, :text
    add_column :films, :trailer_url, :string
    add_column :films, :homepage_url, :string
  end

  def self.down
    remove_column :films, :homepage
    remove_column :films, :trailer_url
    remove_column :films, :genres
    remove_column :films, :cast
  end
end
