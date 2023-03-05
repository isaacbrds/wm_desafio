class Employee < ApplicationRecord
  validates :name, :position, :admission_date, presence: true

  has_many :vacations, dependent: :destroy

  paginates_per 5
end
