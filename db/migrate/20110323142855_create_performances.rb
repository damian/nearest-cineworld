class CreatePerformances < ActiveRecord::Migration
  def self.up
    create_table :performances do |t|
      t.string :time, :performance_type, :booking_url
      t.boolean :available, :ad, :subtitled
      t.datetime :date
      t.references :film, :cinema
      t.timestamps
    end
  end

  def self.down
    drop_table :performances
  end
end
