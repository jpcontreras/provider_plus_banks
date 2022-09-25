require 'devise/jwt/test_helpers'

module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def create_auth_headers
    user = FactoryBot.create(:user)
    # This will add a valid token for `user` in the `Authorization` header
     Devise::JWT::TestHelpers.auth_headers({}, user)
  end
end