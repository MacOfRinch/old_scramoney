require 'rails_helper'

RSpec.describe "LineAssociates", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/line_associate/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/line_associate/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
