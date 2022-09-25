require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:user) { FactoryBot.create(:user) }

      before do
        post '/auth/sign_up', params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      it 'should return the provider name' do
        expect(json['data']['email']).to eq(user.email)
      end

      it 'should return success message when all attributes are valid' do
        expect(json['message']).to eq(I18n.t('messages.models.user.created'))
      end

      it 'should return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let!(:user) { FactoryBot.create(:user) }

      before do
        post '/auth/sign_up', params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      it 'should return a unprocessable entity errors' do
        post '/auth/sign_up', params: {
          user: {
            email: "",
            password: ""
          }
        }
        expect(json['errors'].count).to eq(2)
      end

      it 'should return error: Email cant be blank' do
        post '/auth/sign_up', params: {
          user: {
            email: "",
            password: user.password
          }
        }
        expect(json['errors'][0]).to eq(I18n.t('activerecord.errors.models.user.attributes.email.blank'))
      end

      it 'should return error: Password cant be blank' do
        post '/auth/sign_up', params: {
          user: {
            email: user.email,
            password: ""
          }
        }
        expect(json['errors'][0]).to eq(I18n.t('activerecord.errors.models.user.attributes.password.blank'))
      end

      it 'should return error: Email taken' do
        post '/auth/sign_up', params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
        expect(json['errors'][0]).to eq(I18n.t('activerecord.errors.models.user.attributes.email.taken'))
      end
    end
  end
end