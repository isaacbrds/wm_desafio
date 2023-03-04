class Vacation < ApplicationRecord
  validates :start_date, :finish_date, presence: true
  belongs_to :employee

  validate :start_date_can_be_at_least_one_year, :finish_date_cannot_be_less_than_start_date,
  :period_can_be_at_least_ten_days

  delegate :name, to: :employee, prefix: :employee

  def start_date_can_be_at_least_one_year
    errors.add(:start_date, "can be at least one year later of admission_date") if employee_id && self.start_date && self.finish_date &&
                                                                                   self.start_date.year - 
                                                                                   self.employee.admission_date.year < 1
  end

  def finish_date_cannot_be_less_than_start_date
    start = self.start_date.to_i
    finish = self.finish_date.to_i
    errors.add(:finish_date, "finish date cannot be less than start date") if finish - start < 0
  end

  def period_can_be_at_least_ten_days
    days = (self.finish_date.to_i - self.start_date.to_i)
    errors.add(:finish_date, "finish date can be at least ten days of start date ") if (days)/86400 < 10
  end
  
  def period_can_be_a_max_of_thirty_days
    days = (self.finish_date.to_i - self.start_date.to_i)
    errors.add(:finish_date, "finish date can be a max of thirty days of start date ") if (days)/86400 >= 30
  end
end
