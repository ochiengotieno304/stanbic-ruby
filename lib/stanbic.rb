# frozen_string_literal: true

require_relative "stanbic/version"

module Stanbic
  autoload :Client, "stanbic/client"
  autoload :Error, "stanbic/error"
  autoload :HttpsStatusCodes, "stanbic/http_status_codes"
  autoload :ApiExceptions, "stanbic/api_exceptions"
end
