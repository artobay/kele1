require 'httparty'
require 'json'
require_relative "roadmap"
class Kele
    include HTTParty
    include Roadmap
     
    def initialize(email,password)
        @api_url = "https://www.bloc.io/api/v1"
        @auth_token = get_auth_token(email,password)
      
    end
    
    def get_auth_token(email,pw)
        response = Kele.post(
            @api_url + "/sessions",
            body: {email: email, password: pw}
        )
        response["auth_token"]
    end
    

   def get_me
       response = JSON.parse(Kele.get(@api_url+"/users/me", headers: { "authorization" => @auth_token}).body)
   end 
   
   def get_mentor_availability(mentor_id)
       response = JSON.parse(Kele.get(@api_url+"/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token}).body)
   end 
   
   

    def get_messages
    response = JSON.parse(Kele.get(@api_url+"/message_threads", headers: { "authorization" => @auth_token}).body)
    end

    def create_message(recipient_id, message,email)
    response = Kele.post(@api_url+"/messages", headers: { "authorization" => @auth_token} , body: { "sender" => email, "recipient_id" => recipient_id, "stripped-text" => message})
    end

   
end 