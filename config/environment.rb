# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
	:user_name => 'app25563468@heroku.com',
	:password => 'Your Password',
	:domain => 'my-bughouse-chess.herokuapp.com',
	:address => 'smtp.sendgrid.net',
	:port => 587,
	:authentication => :plain,
	:enable_starttls_auto => true
}