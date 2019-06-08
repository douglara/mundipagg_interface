require "mundipagg_interface/version"
require "rest-client"
require 'ostruct'
require 'json'
require "base64"

require "mundipagg_interface/custumers/custumer"
require "mundipagg_interface/custumers/card"
require "mundipagg_interface/subscriptions/subscription"

module MundipaggInterface
  class Api

    # Includes
    include MundipaggInterface::Custumers::Custumer
    include MundipaggInterface::Custumers::Card
    include MundipaggInterface::Subscriptions::Subscription

    def initialize(args={})
      @basic_auth_secret_key = args[:basic_auth_secret_key]
      @basic_auth_secret_key_encoded = Base64.strict_encode64("#{@basic_auth_secret_key}:")
      @endpoint_url = 'https://api.mundipagg.com/core/v1'

    end

    def get_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{@basic_auth_secret_key_encoded}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.get("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def put_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{@basic_auth_secret_key_encoded}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        params = params.to_json  unless params.kind_of? String

        parse_response(api_response_kind, RestClient.put("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end


    def post_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{@basic_auth_secret_key_encoded}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        params = params.to_json  unless params.kind_of? String

        parse_response(api_response_kind, RestClient.post("#{@endpoint_url}#{action}", params , headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def delete_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{@basic_auth_secret_key_encoded}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.delete("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue => e
        parse_response('object', e.response)
      end
    end


    def patch_request(action, params={}, headers={})
      begin
        headers = headers.merge({
          'accept' => 'application/json', 
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{@basic_auth_secret_key_encoded}"
        })

        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        params = params.to_json  unless params.kind_of? String

        parse_response(api_response_kind, RestClient.patch("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def parse_response(api_response_kind, response)
      result = OpenStruct.new
      result.status_code = response.code

      if api_response_kind == 'object'
        result.headers = (JSON.parse(response.headers.to_json, object_class: OpenStruct) rescue response.headers)
        result.body = (JSON.parse(response.body, object_class: OpenStruct) rescue response.body)
      elsif api_response_kind == 'hash'
        result.headers = response.headers
        result.body = (JSON.parse(response.body) rescue response.body)
      else
        result.headers = response.headers
        result.body = response.body
      end

      @last_result = result

      result
    end
  
  end
end
