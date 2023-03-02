class Vacation < ApplicationRecord
  validates :start_date, :finish_date,presence: true
  belongs_to :employee
end
