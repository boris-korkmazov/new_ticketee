class Api::V1::BaseController < ApplicationController
  respond_to :json, :xml

  before_action :authentication_user, :check_rate_limit

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
      end
    end

    def check_rate_limit
      if @current_user.request_count > 100
        error = { error: "Rate limit exceeded." }
        render params[:format].to_sym => error, :status=> 403
      else
        @current_user.increment!(:request_count)
      end
    end
end
