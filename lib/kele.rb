require 'httparty'
require_relative 'roadmap'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'
    reply = self.class.post(@base_url + '/sessions', body: { email: email, password: password } )
    @auth_token = reply['auth_token']
  end

  def get_me
    response = self.class.get("#{@base_url}/users/me", headers: { "authorization" => @auth_token } )
    p JSON.parse(response.body)
  end

  # def get_mentor_availability(mentor_id)
  #   # Charlie's mentor_id is 529277
  #   response = self.class.get("#{@base_url}/mentors/#{mentor_id.to_s}/student_availability", { id: mentor_id, content_type: 'application/json', authorization: @auth_token } )
  #   p JSON.parse(response.body)
  # end

  def get_mentor_availability(mentor_id)
    # Charlie's mentor_id is 529277
    response = self.class.get("#{@base_url}/mentors/#{mentor_id.to_s}/student_availability", headers: { authorization: @auth_token } )
    p JSON.parse(response.body)
  end

  def get_messages(msg_page = 0)
    # Using undocumented technique of "?page=n" URL argument from github user hcbviolet from https://github.com/hcbviolet/kele
    if msg_page > 0
      append_uri = "?page=#{msg_page}"
    else
      append_uri = ""
    end
    response = self.class.get("#{@base_url}/message_threads#{append_uri}",  headers: { authorization: @auth_token } )
    p JSON.parse(response.body)
  end

  def create_message(msg_subject, msg_text, thread_token = nil)
    response = self.class.post("#{@base_url}/messages",
        body: {
          user_id: self.get_me['email'],
          recipient_id: self.get_me['current_enrollment']['mentor_id'],
#          token: thread_token,
          subject: msg_subject,
          'stripped-text' => msg_text
          },
        headers: { authorization: @auth_token } )
      p JSON.parse(response.body)
  end

end
