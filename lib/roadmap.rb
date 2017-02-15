module Roadmap

  def get_roadmap(roadmap_id)
    # My roadmap_id is 37
    response = self.class.get("#{@base_url}/roadmaps/#{roadmap_id.to_s}", { id: 0, content_type: 'application/json', authorization: @auth_token } )
    p JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    # Use checkpoint_id of 2265 (Module 1: Frontend Programming Fundamentals)
    response = self.class.get("#{@base_url}/checkpoints/#{checkpoint_id.to_s}", { content_type: 'application/json', authorization: @auth_token } )
    p JSON.parse(response.body)
  end

end
