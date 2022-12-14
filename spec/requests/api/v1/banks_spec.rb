require 'rails_helper'

RSpec.describe 'Api::V1::Banks', type: :request do
  describe 'GET /total' do
    before do
      FactoryBot.create_list(:bank, 3)
      get '/api/v1/banks/total', headers: create_auth_headers
    end

    it 'should return total banks' do
      expect(json['data']).to eq(3)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    before do
      FactoryBot.create_list(:bank, 3)
      get '/api/v1/banks', headers: create_auth_headers
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

    describe 'Succes Request' do
      before do
        get "/api/v1/banks/#{bank.id}", headers: create_auth_headers
      end

      it 'should return bank Id' do
        expect(json['data']['id']).to eq(bank.id)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'Not Found Request' do
      before do
        get "/api/v1/banks/777", headers: create_auth_headers
      end

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:bank) { FactoryBot.create(:bank) }
      
      before do
        post '/api/v1/banks', params: {
          name:  bank.name
        }, headers: create_auth_headers
      end

      it 'should return the bank name' do
        expect(json['data']['name']).to eq(bank.name)
      end

      it 'should return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/banks', headers: create_auth_headers, params: {
          name: ''
        }
      end

      it 'should return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:bank) { FactoryBot.create(:bank) }

    describe 'Succes Request' do
      before do
        delete "/api/v1/banks/#{bank.id}", headers: create_auth_headers
      end

      it 'should return status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    describe 'Not Found Request' do
      before do
        delete "/api/v1/banks/777", headers: create_auth_headers
      end

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /update' do
    let!(:bank) { FactoryBot.create(:bank) }
    let!(:bank_name_updated) { 'HoyTrabajas' }

    describe 'Succes Request' do
      before do
        put "/api/v1/banks/#{bank.id}", headers: create_auth_headers, params: {
          name: bank_name_updated
        }
      end

      it 'should return bank name updated' do
        expect(json['data']['name']).to eq(bank_name_updated)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'Not Found Request' do
      before do
        put "/api/v1/banks/777", headers: create_auth_headers, params: {
          name: bank_name_updated
        }
      end

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
