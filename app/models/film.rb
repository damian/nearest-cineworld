class Film < ActiveRecord::Base
  set_primary_key :edi

  # Relationships
  has_many :performances
  has_friendly_id :title, :use_slug => true

  # Validations
  validates_uniqueness_of :title

  # Scopes
  default_scope order('title asc')
  scope :grouped, group('performances.film_id')
  scope :performances_for_date, lambda { |date| where('performances.date = ?', date) }
  scope :today, performances_for_date(Date.today)
  scope :tomorrow, performances_for_date(Date.today + 1)

end


