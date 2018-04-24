require 'httparty'
require 'json'
require_relative "roadmap"
class Kele
    include HTTParty
    include Roadmap
    base_uri 'https://www.bloc.io/api/v1'
     
    def initialize(email,password)
        @auth_token = get_auth_token(email,password)
    end
    
    def get_auth_token(email,pw)
        response = Kele.post(
            base_uri + "/sessions",
            body: {email: email, password: pw}
        )
        response["auth_token"]
    end
    
    def get_me
        response = JSON.parse(Kele.get(
        base_uri + "/users/me", headers: {
        "authorization" => @auth_token
         }).body)
    end

     def get_mentor_availability(mentor_id)
         response = JSON.parse(Kele.get(
         base_uri + "/mentors/#{mentor_id}/student_availability", headers: {
         "authorization" => @auth_token
         }).body)
     end



      def get_messages
          response = JSON.parse(Kele.get(@api_url + "/message_threads", headers: {
          "authorization" => @auth_token
          }).body)
      end

      def create_message(recipient_id, message, email)
          response = Kele.post(@api_url + "/messages", headers: {
          "authorization" => @auth_token
           }, body: {
            "sender" => email,
            "recipient_id" => recipient_id,
            "stripped-text" => message
            })
       end
    
end 