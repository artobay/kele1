require 'httparty'
require 'json'

class Kele
    include HTTParty

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
   


end 