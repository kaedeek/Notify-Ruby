require 'net/http'
require 'uri'
require 'json'

class LineNotify
    def initialize(token)
        @token = token
        self.Check
    end
    

    def SendMessage(msg, silent = false)
        Post({"message" => msg, "notificationDisabled" => silent})
    end


    def Check
        uri = URI.parse("https://notify-api.line.me/api/status")
        req = Net::HTTP::Get.new(uri)
        req["Authorization"] = "Bearer #{@token}"
        
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
            http.request(req)
        end
        
        if res.code.to_i != 200
            raise "invalid token"
        end
        
        res
    end


    def Post(payload, files = {})
        uri = URI.parse("https://notify-api.line.me/api/notify")
        req = Net::HTTP::Post.new(uri)
        req["Authorization"] = "Bearer #{@token}"
        req.set_form_data(payload)
    
        # Handling file uploads
        files.each do |key, file|
          req.set_form([key, file])
        end
    
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(req)
        end
    
        if res.code.to_i != 200
          raise "some error has occurred :("
        end
    
        res
      end
end