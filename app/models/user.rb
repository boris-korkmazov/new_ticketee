class User < ActiveRecord::Base

  include Tokenable

  validates :email, presence: true

  has_secure_password

  has_many :permissions

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  def self.reset_request_count!
    where("request_count > 0").update_all("request_count = 0")
  end


end
