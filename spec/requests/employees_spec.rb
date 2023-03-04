require 'rails_helper'

RSpec.describe "Employees", type: :request do
  context "GET /employees" do
    let(:url) { "/employees" }
    
    it "returns success status" do
      get url
      expect(response).to have_http_status(:ok)
    end
  end

  context "GET /employees/:id" do
    let(:employee) { create(:employee) }
    let(:url) { "/employees/#{employee.id}" }
    
    it "returns success status" do
      get url
      expect(response).to have_http_status(:ok)
    end 
  end

  context "POST /employees" do
    let(:url) { "/employees" }
    
    context "With valid params" do
      let(:employee_valid_params) { { employee: attributes_for(:employee) } }
      
      it "returns success status" do
        post url, params: employee_valid_params  
        expect(response).to have_http_status(:found)
      end

      it "add a new employee" do
        expect do 
          post url, params: employee_valid_params  
        end.to change(Employee, :count).by(1)
      end
    end

    context "With invalid params" do
      let(:employee_invalid_params) { { employee: attributes_for(:employee, name: nil) } }
      
      it "returns success status" do
        post url, params: employee_invalid_params  
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "add a new employee" do
        expect do 
          post url, params: employee_invalid_params  
        end.to change(Employee, :count).by(0)
      end
    end
  end

  context "PATCH /employees/:id" do
    let(:employee) { create(:employee)}
    let(:url) { "/employees/#{employee.id}" }
    
    context "With valid params" do
      let(:new_name){'John Doe'}
      let(:employee_valid_params) { { employee: {name: new_name}} }
      
      it "returns success status" do
        patch url, params: employee_valid_params  
        expect(response).to have_http_status(:found)
      end

      it "update an employee" do
        patch url, params: employee_valid_params  
        employee.reload
        expect(employee.name).to eq new_name
      end
    end

    context "With invalid params" do
      let(:new_name){nil}
      let(:employee_invalid_params) { { employee: {name: new_name}} }
      
      it "returns success status" do
        patch url, params: employee_invalid_params  
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "update an employee" do
        old_name = employee.name
        patch url, params: employee_invalid_params  
        employee.reload
        expect(employee.name).to eq old_name
      end
    end
  end

  context "DELETE /employees/:id" do
    let(:employee) { create(:employee)}
    let(:url) { "/employees/#{employee.id}" }
    
    it "returns success status" do
      delete url  
      expect(response).to have_http_status(:found)
    end

    it "remove an employee" do
      expect do 
        delete url
      end.to change(Employee, :count).by(0)
    end
  end
end
