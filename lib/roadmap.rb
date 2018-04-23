module Roadmap
    def get_roadmap(roadmap_id)
      response = JSON.parse(Kele.get(@api_url+ "/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token}).body)
    end
  
    def get_checkpoint(checkpoint_id)
      response = Kele.get(@api_url+ "/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token})
    end
end