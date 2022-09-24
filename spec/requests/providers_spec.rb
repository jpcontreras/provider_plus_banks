require 'rails_helper'

RSpec.describe "Providers", type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:provider) { FactoryBot.create(:provider) }

      before do
        post '/api/v1/providers', params: {
          name: provider.name,
          nit: provider.nit,
          contact_name: provider.contact_name,
          contact_cellphone: provider.contact_cellphone,
          account_number: provider.account_number,
          bank_id: provider.bank.id
        }
      end

      it 'should return the provider name' do
        expect(json['name']).to eq(provider.name)
      end

      it 'should return the provider nit' do
        expect(json['nit']).to eq(provider.nit)
      end

      it 'should return the provider contact name' do
        expect(json['contact_name']).to eq(provider.contact_name)
      end

      it 'should return the provider contact cellphone' do
        expect(json['contact_cellphone']).to eq(provider.contact_cellphone)
      end

      it 'should return the provider account number' do
        expect(json['account_number']).to eq(provider.account_number)
      end

      it 'should return the provider bank ID' do
        expect(json['bank_id']).to eq(provider.bank.id)
      end

      it 'should return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/providers', params: {
          name: '',
          contact_name: ''
        }
      end

      it 'should return a unprocessable entity errors' do
        total_errors = json['errors'].count
        expect(json['errors'].count).to eq(total_errors)
      end

      it 'should return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
