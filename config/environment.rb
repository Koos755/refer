# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Refer::Application.initialize!

# Rails.application.routes.default_url_options[:host] = 'localhost:3000'
# Rails.application.routes.default_url_options[:host] = 'surerefer.herokuapp.com'

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => 'surerefer.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

