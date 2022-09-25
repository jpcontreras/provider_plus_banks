class AuthorizeController < ApplicationController
  before_action :authenticate_user!

end