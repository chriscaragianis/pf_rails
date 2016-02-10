class Scenario < ActiveRecord::Base

  has_many :balance_records

  validates :name, presence: true, length: { minimum: 2 }
  validates :vest_level, presence: true

end
