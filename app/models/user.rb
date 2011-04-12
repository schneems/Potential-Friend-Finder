class User < ActiveRecord::Base  
  validates_uniqueness_of :username
  
  
  # not a production app, lets not worry about those silly passwords and logins
  acts_as_authentic do |c|
    c.require_password_confirmation = false
    c.validate_password_field = false
    c.ignore_blank_passwords = false
    c.validate_login_field = false
    c.validate_email_field = false
  end
  
  
  def get(username)
    where(:username => username).first
  end
  
  
end