require 'rails_helper'

RSpec.describe 'Formats', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/formats/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/formats/create'
      expect(response).to have_http_status(:success)
    end
  end
end
