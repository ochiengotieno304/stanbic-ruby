require "faraday"
require "faraday_middleware"
require "json"

module Stanbic
  class Client
    HTTP_OK_CODE = 200
    BASE_URL = "https://api.connect.stanbicbank.co.ke/api/sandbox/".freeze
    attr_reader :adapter, :api_key, :api_secret, :currency_code

    def initialize(api_key:, api_secret:, currency_code: "KES", adapter: Faraday.default_adapter)
      @api_key = api_key
      @api_secret = api_secret
      @adapter = adapter
      @currency_code = currency_code
    end

    def stanbic_payments(account_to, amount)
      dbs_reference_id = Random.rand(1_000_000_000_000)
      end_to_end_id = Random.rand(1_000_000_000)
      post_body = {
        "originatorAccount": {
          "identification": {
            "mobileNumber": ""
          }
        },

        "requestedExecutionDate": Time.now.strftime("%Y-%m-%d"),

        "dbsReferenceId": dbs_reference_id.to_s,

        "txnNarrative": "TRANSACTION NARRATIVE",

        "callBackUrl": "http://clientdomain.com/omnichannel/esbCallback",

        "transferTransactionInformation": {
          "instructedAmount": {
            "amount": amount.to_s,
            "currencyCode": currency_code
          },

          "counterparty": {
            "name": "J. Sparrow",
            "postalAddress": {
              "addressLine1": "Some street",
              "addressLine2": "99",
              "postCode": "1100 ZZ",
              "town": "Amsterdam",
              "country": "NL"
            }
          },

          "counterpartyAccount": {
            "identification": {
              "identification": account_to.to_s
            }
          },

          "remittanceInformation": {
            "type": "UNSTRUCTURED",
            "content": "SALARY"
          },

          "endToEndIdentification": end_to_end_id.to_s
        }
      }

      request(http_method: :post, endpoint: "stanbic-payments", params: post_body)
    end

    def inter_bank_transfer(options)
      request(http_method: :post, endpoint: "pesalink-payments", params: options)
    end

    def mobile_money
      request(http_method: :post, endpoint: "mobile-payments", params: options)
    end

    def inspect
      "#<Stanbic::Client>"
    end

    private

    def get_token(client_id, client_secret)
      data = {
        scope: "payments",
        grant_type: "client_credentials",
        client_id: client_id,
        client_secret: client_secret
      }

      url = "https://api.connect.stanbicbank.co.ke/api/sandbox/auth/oauth2/token"
      response = Faraday.post(url) do |req|
        req.headers["Content-Type"] = "application/x-www-form-urlencoded"
        req.body = URI.encode_www_form(data)
      end

      parsed_response = JSON.parse(response.body)

      OpenStruct.new(parsed_response).access_token
    end

    def connection
      token = get_token(api_key, api_secret)

      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.headers["Authorization"] = "Bearer #{token}"
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end

    def request(http_method:, endpoint:, params: {})
      response = connection.public_send(http_method, endpoint, params)
      parsed_response = OpenStruct.new(response.body)
      # response.body

      # return parsed_response.httpCode if parsed_response.httpCode == response_successful?

      # raise error_class, "Code: #{response.status}, response: #{response.body}"
    end

    # def get_token(client_id:, client_secret:)
    #   params = {
    #     scope: "payments",
    #     grant_type: "client_credentials",
    #     client_id: client_id,
    #     client_secret: client_secret
    #   }

    #   url = "https://api.connect.stanbicbank.co.ke/api/sandbox/auth/oauth2/token"

    #   request(post, url, params)
    # end

    # def error_class
    #   case response.status
    #   when HTTP_BAD_REQUEST_CODE
    #     BadRequestError
    #   when HTTP_UNAUTHORIZED_CODE
    #     UnauthorisedError
    #   when HTTP_FORBIDDEN_CODE
    #     ForbiddenError
    #   when HTTP_NOT_FOUND_CODE
    #     NotFoundError
    #   when HTTP_UNPROCESSABLE_ENTITY_CODE
    #     UnprocessableEntityError
    #   else
    #     APIError
    #   end
    # end

    def response_successful?
      HTTP_OK_CODE
    end
  end
end
