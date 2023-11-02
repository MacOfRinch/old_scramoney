# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notices', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/notices/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/notices/show'
      expect(response).to have_http_status(:success)
    end
  end
end
