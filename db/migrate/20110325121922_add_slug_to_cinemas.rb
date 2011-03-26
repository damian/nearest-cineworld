class AddSlugToCinemas < ActiveRecord::Migration
  def self.up
    add_column :cinemas, :cached_slug, :string
  end

  def self.down
    remove_column :cinemas, :cached_slug
  end
end
