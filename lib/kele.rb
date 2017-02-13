require 'rubygems' if RUBY_VERSION < '1.9'
require 'rest_client'
require 'httparty'

class Kele
  include HTTParty
  attr_reader :user_token

  def initialize(email, password)

    @email = email
    @password = password
    headers = {
      :content_type => 'application/json'
    }

    @base_url = 'https://www.bloc.io/api/v1'
    @user_token = self.class.post('https://www.bloc.io/api/v1/sessions', { "email": @email, "password": @password }, headers )
  end
end
