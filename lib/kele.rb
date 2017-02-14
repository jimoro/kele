require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'
    reply = self.class.post(@base_url + '/sessions', body: { email: email, password: password } )
    @auth_token = reply['auth_token']
  end

  def get_me
    response = self.class.get(@base_url + '/users/me', headers: { "authorization" => @auth_token } )
    p JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(@base_url + '/mentors/' + mentor_id.to_s + '/student_availability', { id: mentor_id, content_type: 'application/json', authorization: @auth_token } )
  end

end
