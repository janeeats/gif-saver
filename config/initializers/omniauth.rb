OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY_DEV'], ENV['FACEBOOK_SECRET_DEV'],
           { :scope => 'publish_stream,publish_actions' }
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'] 
end

Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
end