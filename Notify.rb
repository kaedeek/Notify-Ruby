require 'net/http'
require 'uri'
require 'json'

class LineNotify
    def initialize(token)
        @token = token
        check_token
    end
    

    def SendMessage(msg, silent = false)
        Post({"message" => msg, "notificationDisabled" => silent})
    end

    private

    def check_token
        url = URI.parse("https://notify-api.line.me/api/status")
        req = Net::HTTP::Get.new(url)
        req["Authorization"] = "Bearer #{@token}"
        
        res = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == "https") do |http|
            http.request(req)
        end
        
        if res.code.to_i != 200
            raise "invalid token"
        end
        
        res
    end


    def Post(payload, files = {})
        url = URI.parse("https://notify-api.line.me/api/notify")
        req = Net::HTTP::Post.new(url)
        req["Authorization"] = "Bearer #{@token}"
        req.set_form_data(payload)
    
        # Handling file uploads
        files.each do |key, file|
          req.set_form([key, file])
        end
    
        res = Net::HTTP.start(url.hostname, url.port, use_ssl: url.scheme == "https") do |http|
          http.request(req)
        end
    
        if res.code.to_i != 200
          raise "some error has occurred :("
        end
    
        res
      end
end