class CreateFilms < ActiveRecord::Migration
  def self.up
    create_table :cinemas do |t|
      t.string  :name, :cinema_url
      t.text    :address
      t.string  :postcode, :telephone
      t.float   :lat, :lng
      t.timestamps
    end
  end

  def self.down
    drop_table :cinemas
  end
end
