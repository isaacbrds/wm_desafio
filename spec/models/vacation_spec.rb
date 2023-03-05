require 'rails_helper'

RSpec.describe Vacation, type: :model do
  
  let(:employee){create(:employee, admission_date: Date.today.years_ago(1))}
  let(:vacation){create(:vacation, employee: employee, 
    start_date: Date.today, finish_date: Date.today + 30.day )}

  describe 'associations' do
    it { is_expected.to belong_to(:employee) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:finish_date) }
  end

  describe 'custom validations with valid params' do
    
    

    

    it "employee should have one year of work" do
      expect(vacation).to be_valid
    end

    it "start_date should be less than finish date" do  
      expect(vacation).to be_valid
    end

    it "period should be at least ten days" do
      
      expect(vacation).to be_valid
    end

    it "period should be a max of thirty days" do
      expect(vacation).to be_valid
    end

    describe "period shouldn't be overlapping" do 
      let(:another_employee){create(:employee, admission_date: Date.today.years_ago(1) - 1.month)}
      let(:vacations_same_date){create(:vacation, employee: another_employee, 
        start_date: Date.today, finish_date: Date.today + 30.day) }
      it "should be overlapping" do
        expect(vacations_same_date).to be_valid
      end
    end
  end
end
