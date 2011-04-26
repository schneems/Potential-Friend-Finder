class Admin < ActiveRecord::Base
  acts_as_authentic do |c|
    c.require_password_confirmation = false
    c.validate_password_field = false
    c.validate_login_field = false
    c.validate_email_field = false
  end
  
  
  has_many :users
  
end