class Performance < ActiveRecord::Base
  belongs_to :film, :foreign_key => 'film_id'
  belongs_to :cinema, :foreign_key => 'cinema_id'

  # Scopes
  scope :for_cinema, lambda { |cinema| where('cinema_id = ?', cinema.id) }
  scope :for_date, lambda { |date| where('date = ?', date) }
  scope :today, for_date(Date.today)
  scope :tomorrow, for_date(Date.today + 1)

end


