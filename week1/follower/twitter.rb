require 'rubygems'
require 'oauth'
require 'twitter'
require 'launchy'

consumer_key = 'lZ8lKntl98zIqs4fvEzlQ'
consumer_secret = 'KtMpcSvRQpmAVwj4Kdq7vbMvslIImmNxh0C5Ack'

@consumer = OAuth::Consumer.new(
  consumer_key, 
  consumer_secret, 
  {:site => 'http://twitter.com'}
)

# Get the request token & PIN
@request_token = @consumer.get_request_token
Launchy.open(@request_token.authorize_url)
puts "When you're ready, enter the number they give you: "
pin = gets.chomp

# Get the access token that tells us the user logged in and agreed to our access
@access_token = @request_token.get_access_token(:oauth_verifier => pin)
puts "The access token is #{ @access_token.token }"
puts "The access secret is #{ @access_token.secret }"

# Let's authenticate you, user.
Twitter.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = @access_token.token
  config.oauth_token_secret = @access_token.secret
end