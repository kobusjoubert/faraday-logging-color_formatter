# frozen_string_literal: true

require_relative 'color_formatter/version'
require_relative 'color_formatter/formatter'

module Faraday
  module Logging
    module ColorFormatter
      class Error < StandardError; end

      class << self
        def new(...)
          Faraday::Logging::ColorFormatter::Formatter.new(...)
        end
      end
    end
  end
end
