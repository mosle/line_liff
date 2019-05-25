require "line-bot-api"
require "line_liff/version"

unless Line::Bot::HTTPClient.method_defined? :put
  module Line
    module Bot
      class HTTPClient
          def put(url, payload, header = {})
            uri = URI(url)
            http(uri).put(uri.request_uri, payload, header)
          end
      end
    end
  end
end

unless Line::Bot::Request.method_defined? :put
  module Line
    module Bot
      class Request
          def put
            httpclient.put(endpoint + endpoint_path, payload, header)
          end
      end
    end
  end
end

unless Line::Bot::Client.method_defined? :put
  module Line
    module Bot
      class Client
        def put(endpoint_path, payload = nil)
            raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?
      
            request = Line::Bot::Request.new do |config|
              config.httpclient     = httpclient
              config.endpoint       = endpoint
              config.endpoint_path  = endpoint_path
              config.credentials    = credentials
              config.payload        = payload if payload
            end
      
            request.put
        end
      end
    end
  end
end

module Line
  module Bot
    class LiffClient < Line::Bot::Client
      @@api_version = "v1"

      def self.create_by_line_bot_client line_bot_client
          self.new{|config|
              config.channel_secret = line_bot_client.channel_secret
              config.channel_token = line_bot_client.channel_token
          }
      end
      #def self.api_version
      #  @@api_version
      #end
      def self.default_endpoint
        "https://api.line.me/liff/#{@@api_version}/apps"
      end
      def endpoint
          @endpoint ||= self.class.default_endpoint
      end
      def get_liffs
          endpoint_path  = ""
          get endpoint_path
      end

      def create_liff type,url,description = nil,features = {}
          payload = {
              view:{
                  type:type,url:url
              },
              description:description,
              features:features
          }
          post "", payload.to_json
      end
      def update_liff liff_id,type=nil,url=nil,description = nil,features = {}
          payload = {}
          payload[:view] = {type:type,url:url}.reject { |k,v| v.nil? }
          payload[:description] = description
          payload[:features] = features
          payload.reject!{|k,v| v.nil? or v.length == 0}
          put "/#{liff_id}", payload.to_json
      end

      def delete_liff liff_id
          delete "/#{liff_id}"
      end
    end
  end
end
