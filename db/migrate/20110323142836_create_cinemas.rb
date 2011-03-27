class CreateCinemas < ActiveRecord::Migration
  def self.up
    create_table :films do |t|
      t.integer :edi
      t.string :title, :poster_url, :film_url, :still_url, :advisory
      t.string :classification, :length => 10
      t.string :cached_slug
      t.timestamps
    end
    add_index :films, :cached_slug, :unique => true
    add_index :films, :edi, :unique => true
  end

  def self.down
    drop_table :films
  end
end
