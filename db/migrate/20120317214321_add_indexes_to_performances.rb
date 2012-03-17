class AddIndexesToPerformances < ActiveRecord::Migration
  def self.up
    add_index :performances, :film_id
    add_index :performances, :cinema_id
    add_index :performances, :date
  end

  def self.down
    remove_index :performances, :column => :date
    remove_index :performances, :column => :cinema_id
    remove_index :performances, :column => :film_id
  end
end
