# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FamilyProfiles', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/family_profiles/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/family_profiles/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/family_profiles/update'
      expect(response).to have_http_status(:success)
    end
  end
end
