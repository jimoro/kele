require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'
    reply = self.class.post(@base_url + '/sessions', body: { email: email, password: password } )
    @auth_token = reply['auth_token']
  end

  def get_me
    response = self.class.get(@base_url + '/users/me', headers: { "authorization" => @auth_token })
    p JSON.parse(response.body)
  end

end
