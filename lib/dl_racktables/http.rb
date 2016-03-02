require 'net/http'
require 'uri'

module DLRacktables
  class HTTP
    PREFIX = '/racktables/'

    def self.get(get_params)
      Net::HTTP.start(Config['server']) do |http|
        req = Net::HTTP::Get.new(PREFIX + get_params)
        req.basic_auth Config['userid'], Config['passwd']

        send_request(http, req)
      end
    end
    
    def self.post(get_params, post_params)
      Net::HTTP.start(Config['server']) do |http|
        req = Net::HTTP::Post.new(PREFIX + get_params)
        req.basic_auth Config['userid'], Config['passwd']
        req.set_form_data(post_params)

        send_request(http, req)
      end
    end

    private
    def self.send_request(http, req)
      response = http.request(req)
      case response
      when Net::HTTPSuccess
        response
      when Net::HTTPRedirection
        get(response['location'])
      else
        puts response
        response.error!
      end
    end
  end
end
