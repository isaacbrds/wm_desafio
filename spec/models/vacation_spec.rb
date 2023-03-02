require 'rails_helper'

RSpec.describe Vacation, type: :model do
  describe 'associations' do
    it { should belong_to(:employee) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:finish_date) }
  end

  describe 'custom validations' do
    let(:employee){create(:employee, admission_date: Date.today)}
    let(:vacation){create(:vacation, start_date: Date.today)}
    
    it 'should have one year for vacation rights' do
      expect(vacation).to be_valid
    end

    it 'should have a max of 30 days for year' do
      vacation.start_date =  Date.today 
      vacation.finish_date = Date.today + 30.day
      expect(vacation).to be_valid
    end

    it 'should have a min of 10 days for vacation period' do
      vacation.start_date =  Date.today 
      vacation.finish_date = Date.today + 10.day
      expect(vacation).to be_valid
    end
  end
end
