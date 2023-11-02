# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApprovalRequests', type: :request do
  describe 'GET /approve' do
    it 'returns http success' do
      get '/approval_requests/approve'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /refuse' do
    it 'returns http success' do
      get '/approval_requests/refuse'
      expect(response).to have_http_status(:success)
    end
  end
end
