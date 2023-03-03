require 'rails_helper'

RSpec.describe "Vacations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/vacations/index"
      expect(response).to have_http_status(:success)
    end
  end

end
