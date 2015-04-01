class Api::V1::BaseController < ApplicationController
  respond_to :json, :xml

  before_action :authentication_user

  private

    def authentication_user
      @current_user = User.find_by_authentication_token(params[:token])

      unless @current_user
        respond_with( error: "Token is invalid.")
      end
    end

    def current_user
      @current_user
    end
end
