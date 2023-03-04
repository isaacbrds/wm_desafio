require 'rails_helper'

RSpec.describe "Vacations", type: :request do
  context "GET /vacations" do
    let(:url) { "/vacations" }
    
    it "returns success status" do
      get url
      expect(response).to have_http_status(:ok)
    end
  end

  context "GET /vacations/:id" do
    let(:vacation) { create(:vacation, start_date: Date.today, 
                            finish_date: Date.today + 20.day) }
    let(:url) { "/vacations/#{vacation.id}" }
    
    it "returns success status" do
      get url
      expect(response).to have_http_status(:ok)
    end 
  end

  context "POST /vacations" do
    let(:url) { "/vacations" }
    
    context "With valid params" do
      let(:employee){create(:employee)}
      let(:vacation_valid_params) { { vacation: attributes_for(:vacation, 
                                      start_date: Date.today, 
                                      finish_date: Date.today + 20.day,
                                      employee_id: employee.id
                                      ) } }
      
      it "returns success status" do
        post url, params: vacation_valid_params  
        expect(response).to have_http_status(:found)
      end

      it "add a new vacation" do
        expect do 
          post url, params: vacation_valid_params  
        end.to change(Vacation, :count).by(1)
      end
    end

    context "With invalid params" do
      let(:vacation_invalid_params) { { vacation: attributes_for(:vacation, name: nil) } }
      
      it "returns success status" do
        post url, params: vacation_invalid_params  
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "add a new vacation" do
        expect do 
          post url, params: vacation_invalid_params  
        end.to change(Vacation, :count).by(0)
      end
    end
  end

  context "DELETE /vacations/:id" do
    let(:vacation) { create(:vacation, start_date: Date.today, 
                            finish_date: Date.today + 20.day)}

    let(:url) { "/vacations/#{vacation.id}" }
    
    it "returns success status" do
      delete url  
      expect(response).to have_http_status(:found)
    end

    it "remove an vacation" do
      expect do 
        delete url
      end.to change(Vacation, :count).by(0)
    end
  end

  context "PATCH /vacations/:id" do
    let(:employee) { create(:employee)}
    let(:vacation) { create(:vacation, start_date: Date.today, 
      finish_date: Date.today + 20.day)}

    let(:url) { "/vacations/#{vacation.id}" }
    
    context "With valid params" do
      let(:start_date){Date.today + 1.day}
      let(:vacation_valid_params) { { vacation: {start_date: start_date}} }
      
      it "returns success status" do
        patch url, params: vacation_valid_params  
        expect(response).to have_http_status(:found)
      end

      it "update a vacation" do
        patch url, params: vacation_valid_params  
        vacation.reload
        expect(vacation.start_date).to eq start_date
      end
    end

    context "With invalid params" do
      let(:start_date){Date.today + 20.day}
      let(:vacation_invalid_params) { { vacation: {start_date: start_date}} }
      
      it "returns success status" do
        patch url, params: vacation_invalid_params  
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "update an employee" do
        start_date = vacation.start_date
        patch url, params: vacation_invalid_params  
        vacation.reload
        expect(vacation.start_date).to eq start_date
      end
    end
  end
end
