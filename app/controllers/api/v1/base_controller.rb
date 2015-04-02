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

    def authorize_admin!
      if ! @current_user.admin?
        error = {error: "You must be an admin to do that."}
       # warden.custom_failure!
        render params[:format].to_sym => error, :status=> 401
        #respond_with(error, status: 404)
      end
    end
end
