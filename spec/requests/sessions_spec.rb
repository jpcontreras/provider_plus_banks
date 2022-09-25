require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:user) { FactoryBot.create(:user) }

      before do
        post '/auth/sign_in', params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      it 'should return success message when all attributes are valid' do
        expect(json['message']).to eq(I18n.t('messages.models.user.sign_in.success'))
      end

      it 'should return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do

      before(:each) do
        @email = Faker::Internet.email
        post '/auth/sign_in', params: {
          user: {
            email: @email,
            password: Faker::Number.number(digits: 6)
          }
        }
      end

      it 'should return a unprocessable entity errors' do
        post '/auth/sign_in', params: {
          user: {
            email: "",
            password: ""
          }
        }
        expect(json['errors'][0]).to eq(I18n.t('messages.models.user.sign_in.wrong'))

      end

      it 'should return error: Email or Password cant be wrong' do
        post '/auth/sign_in', params: {
          user: {
            email: "",
            password: Faker::Number.number(digits: 6)
          }
        }
        expect(json['errors'][0]).to eq(I18n.t('messages.models.user.sign_in.wrong'))
      end
    end
  end
end