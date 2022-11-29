require "oj"
require "faraday"
require "faraday_middleware"

module Stanbic
  class Client
    BASE_URL = "https://api.connect.stanbicbank.co.ke/api/sandbox/".freeze
    attr_reader :token, :adapter

    def initialize(token:, adapter: Faraday.default_adapter)
      @token = token
      @adapter = adapter
    end

  @body = '{
  "originatorAccount": {
    "identification": {
      "mobileNumber": "0743287562"
    }
  },
  "requestedExecutionDate": "2022-11-27",
  "dbsReferenceId": "989892717711",
  "txnNarrative": "TRANSACTION NARRATIVE",
  "callBackUrl": "http://clientdomain.com/omnichannel/esbCallback",
  "transferTransactionInformation": {
    "instructedAmount": {
      "amount": "100.00",
      "currencyCode": "KES"
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
        "identification": "0100004614423"
      }
    },
    "remittanceInformation": {
      "type": "UNSTRUCTURED",
      "content": "SALARY"
    },
    "endToEndIdentification": "5e1a3da132cc"
  }
}'

  @body_loan = '{
  "RequestId": "67dhbbs-dgjsnh76-shjbs87sg-ahsfnn",
  "EntityName": "",
  "EntityProduct": "LOAN",
  "LoanAmount": "1000.00",
  "LoanCurrency": "KES",
  "LoanTerm": "14D",
  "PaymentReferenceId": "EBLEB109209192019",
  "CallBackUrl": "https://partner.com/embeddedlending/v1/callback",
  "MaxAllowedLimit": "70000.00",
  "MobileNumber": "254114507894",
  "DisbursementMode": "ACCOUNT"
}'

    def stanbic_payments(_params)
      request(http_method: :post, endpoint: "stanbic-payments", params: @body)
    end

    def create_loan(_params)
      request(http_method: :post, endpoint: "create-loan", params: params)
    end

    def inspect
      "#<Stanbic::Client>"
    end

    private

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.headers["Authorization"] = "Bearer #{token}"
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end

    def request(http_method:, endpoint:, params: {})
      connection.public_send(http_method, endpoint, params)
    end
  end
end
