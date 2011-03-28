class AddTmdbInfoToFilms < ActiveRecord::Migration
  def self.up
    add_column :films, :imdb_id, :string
    add_column :films, :tmdb_url, :string
    add_column :films, :overview, :text
    add_column :films, :posters, :text
    add_column :films, :backdrops, :text
    add_column :films, :release_date, :date
    add_column :films, :popularity, :integer
    add_column :films, :votes, :integer
    add_column :films, :rating, :float, :precision => 2
  end

  def self.down
    remove_column :films, :rating
    remove_column :films, :votes
    remove_column :films, :popularity
    remove_column :films, :release_date
    remove_column :films, :backdrops
    remove_column :films, :posters
    remove_column :films, :overview
    remove_column :films, :tmdb_url
    remove_column :films, :imdb_id
  end
end
