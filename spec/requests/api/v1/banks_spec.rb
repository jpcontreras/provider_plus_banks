require 'rails_helper'

RSpec.describe 'Api::V1::Banks', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:bank, 3)
      get '/api/v1/banks'
    end

    it 'should return all banks' do
      expect(json.size).to eq(3)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let!(:bank) { FactoryBot.create(:bank) }

    before do
      get "/api/v1/banks/#{bank.id}"
    end

    it 'should return bank Id' do
      expect(json['id']).to eq(bank.id)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:bank) { FactoryBot.create(:bank) }
      
      before do
        post '/api/v1/banks', params: {
          name: bank.name
        }
      end

      it 'should return the bank name' do
        expect(json['name']).to eq(bank.name)
      end

      it 'should return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/banks', params: {
          name: ''
        }
      end

      it 'should return a unprocessable entity status' do
        puts response
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:bank) { FactoryBot.create(:bank) }

    before do
      delete "/api/v1/banks/#{bank.id}"
    end

    it 'should return status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'PUT /update' do
    let!(:bank) { FactoryBot.create(:bank) }
    let!(:bank_name_updated) { 'HoyTrabajas' }

    before do
      put "/api/v1/banks/#{bank.id}", params: {
        name: bank_name_updated
      }
    end

    it 'should return bank name updated' do
      expect(json['name']).to eq(bank_name_updated)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
