# frozen_string_literal: true

require_relative "stanbic/version"

module Stanbic
  autoload :Client, "stanbic/client"
  autoload :Error, "stanbic/error"
end
