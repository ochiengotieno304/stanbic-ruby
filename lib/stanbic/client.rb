require "faraday"
require "faraday_middleware"

module Stanbic
  class Client
    BASE_URL = "https://api.connect.stanbicbank.co.ke/api/sandbox/"
    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :xml
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end

    def inspect
      "<Stanbic::Client>"
    end
  end
end
