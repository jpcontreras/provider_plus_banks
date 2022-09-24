require 'rails_helper'

RSpec.describe "Api::V1::Providers", type: :request do
  describe 'GET /total' do
    before do
      FactoryBot.create_list(:provider, 3)
      get '/api/v1/providers/total'
    end

    it 'should return total providers' do
      expect(json['data']).to eq(3)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    before do
      FactoryBot.create_list(:provider, 11)
      get '/api/v1/providers'
    end

    it 'should return the id attribute in the list' do
      expect(json['data'][0]['id'].present?).to eq(true)
    end

    it 'should return the name attribute in the list' do
      expect(json['data'][0]['name'].present?).to eq(true)
    end

    it 'should return the contact name attribute in the list' do
      expect(json['data'][0]['contact_name'].present?).to eq(true)
    end

    # it 'should return the contact cellphone attribute in the list' do
    #   expect(json['data'][0]['contact_cellphone'].present?).to eq(true)
    # end

    it 'should return the bank name attribute in the list' do
      expect(json['data'][0]['bank_name'].present?).to eq(true)
    end

    # it 'should return the account number attribute in the list' do
    #   expect(json['data'][0]['account_number'].present?).to eq(true)
    # end

    it 'should return all providers rows allowed' do
      expect(json['data'].size).to eq(10)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let!(:provider) { FactoryBot.create(:provider) }

    describe 'Succes Request' do
      before do
        get "/api/v1/providers/#{provider.id}"
      end

      it 'should return provider allowed attributes' do
        expect(json['id']).to eq(provider.id)
        expect(json['name']).to eq(provider.name)
        expect(json['contact_name']).to eq(provider.contact_name)
        expect(json['bank_name']).to eq(provider.bank.name)
        # expect(json['contact_cellphone']).to eq(provider.contact_cellphone)
        # expect(json['account_number']).to eq(provider.account_number)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'Not Found Request' do
      before do
        get "/api/v1/providers/777"
      end

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

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
        expect(json['data']['name']).to eq(provider.name)
      end

      it 'should return the provider nit' do
        expect(json['data']['nit']).to eq(provider.nit)
      end

      it 'should return the provider contact name' do
        expect(json['data']['contact_name']).to eq(provider.contact_name)
      end

      it 'should return the provider contact cellphone' do
        expect(json['data']['contact_cellphone']).to eq(provider.contact_cellphone)
      end

      it 'should return the provider account number' do
        expect(json['data']['account_number']).to eq(provider.account_number)
      end

      it 'should return the provider bank ID' do
        expect(json['data']['bank_id']).to eq(provider.bank.id)
      end

      it 'should return success message when all attributes are valid' do
        expect(json['message']).to eq(I18n.t('messages.models.provider.created'))
      end

      it 'should return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let!(:bank) { FactoryBot.create(:bank) }
      before do
        post '/api/v1/providers', params: {
          name: '',
          contact_name: '',
          bank_id: ''
        }
      end

      it 'should return a unprocessable entity errors' do
        total_errors = json['errors'].count
        expect(json['errors'].count).to eq(total_errors)
      end

      it 'should return error: Name cant be blank' do
        post '/api/v1/providers', params: {
          name: '',
          contact_name: Faker::Name.name,
          bank_id: bank.id
        }
        expect(json['errors'].count).to eq(1)
      end

      it 'should return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:provider) { FactoryBot.create(:provider) }

    describe 'Succes Request' do
      before do
        delete "/api/v1/providers/#{provider.id}"
      end

      it 'should return status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    describe 'Not Found Request' do
      before do
        delete "/api/v1/providers/777"
      end

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /update' do
    let!(:provider) { FactoryBot.create(:provider) }
    let!(:values_updated) {
      {
        name: Faker::Name.name,
        nit: "#{Faker::Number.number(digits: 9)}-#{Faker::Number.number(digits: 1)}",
        contact_name: Faker::Name.name,
        contact_cellphone: "#{Faker::Number.number(digits: 10)}",
        account_number: "#{Faker::Number.number(digits: 15)}"
      }
    }

    describe 'with valid parameters' do
      before do
        put "/api/v1/providers/#{provider.id}", params: values_updated
      end

      it 'should return provider name updated' do
        expect(json['name']).to eq(values_updated[:name])
        expect(json['contact_name']).to eq(values_updated[:contact_name])
        # expect(json['nit']).to eq(values_updated[:nit])
        # expect(json['contact_cellphone']).to eq(values_updated[:contact_cellphone])
        # expect(json['account_number']).to eq(values_updated[:account_number])
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let!(:bank) { FactoryBot.create(:bank) }
      before do
        put "/api/v1/providers/#{provider.id}", params: {
          name: '',
          contact_name: '',
          bank_id: ''
        }
      end

      it 'should return a unprocessable entity errors' do
        total_errors = json['errors'].count
        expect(json['errors'].count).to eq(total_errors)
      end

      it 'should return error: Name, Contact Name and Bank cant be blank' do
        put "/api/v1/providers/#{provider.id}", params: {
          name: '',
          contact_name: '',
          bank_id: ''
        }
        expect(json['errors'].count).to eq(3)
      end

      it 'should return a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'Not Found Request' do
      before do
        put "/api/v1/providers/777", params: values_updated
      end

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
