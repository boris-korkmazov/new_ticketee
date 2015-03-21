class Permission < ActiveRecord::Base
  belongs_to :thing, polymorphic: true
  belongs_to :user
end
