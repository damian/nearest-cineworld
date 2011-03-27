class CreateFilms < ActiveRecord::Migration
  def self.up
    create_table :cinemas do |t|
      t.integer :cinema_id
      t.string  :name, :cinema_url
      t.text    :address
      t.string  :postcode, :telephone
      t.float   :lat, :lng
      t.string :cached_slug
      t.timestamps
    end
    add_index :cinemas, :cached_slug, :unique => true
    add_index :cinemas, :cinema_id, :unique => true
  end

  def self.down
    drop_table :cinemas
  end
end
