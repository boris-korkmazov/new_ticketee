module Tokenable
  extend ActiveSupport::Concern


  included do
    before_save :generate_token
  end

  private
    def generate_token
      self.authentication_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless self.class.exists?(authentication_token: random_token)
      end
    end
end