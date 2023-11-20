require 'rails_helper'

RSpec.describe "LineEvents", type: :request do
  describe "GET /recieve" do
    it "returns http success" do
      get "/line_events/recieve"
      expect(response).to have_http_status(:success)
    end
  end

end
