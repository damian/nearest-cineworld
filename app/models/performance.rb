# == Schema Information
#
# Table name: performances
#
#  id               :integer(4)      not null, primary key
#  time             :string(255)
#  performance_type :string(255)
#  booking_url      :string(255)
#  available        :boolean(1)
#  ad               :boolean(1)
#  subtitled        :boolean(1)
#  date             :datetime
#  film_id          :integer(4)
#  cinema_id        :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

class Performance < ActiveRecord::Base
  # Relationships
  belongs_to :film, :foreign_key => 'film_id'
  belongs_to :cinema, :foreign_key => 'cinema_id'

  # Validations
  validates_uniqueness_of :booking_url

  # Scopes
  scope :for_cinema, lambda { |cinema| where('cinema_id = ?', cinema) }
  scope :for_date, lambda { |date| where('date = ?', date) }
  scope :today, for_date(Date.today)
  scope :tomorrow, for_date(Date.today + 1)

  def in_the_past?
    now = Time.now
    Time.zone.local(now.year, now.month, now.day, hours, minutes, 0).past?
  end

  def hours
    @hours ||= time.split(':')[0]
  end

  def minutes
    @minutes ||= time.split(':')[1]
  end

end


