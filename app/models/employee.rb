class Employee < ApplicationRecord
  validates :name, :position, :admission_date, presence: true
end
