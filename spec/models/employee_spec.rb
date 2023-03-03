require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'associations' do
    it { should have_many(:vacations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:admission_date) }
  end
end
