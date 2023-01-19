# frozen_string_literal: true

require 'faraday'

module Faraday
  module Logging
    module ColorFormatter
      class Formatter < Faraday::Logging::Formatter
        ANSI_COLORS = { red: "\e[31m", green: "\e[32m", yellow: "\e[33m", blue: "\e[34m", magenta: "\e[35m", cyan: "\e[36m", reset: "\e[0m" }.freeze

        def initialize(logger:, options:)
          @prefix = { request: 'HTTP Request', response: 'HTTP Response', indent: 0 }.merge(options.delete(:prefix) || {})

          super
        end

        def request(env)
          http_request_term = (prefix[:request].nil? || prefix[:request].strip.empty?) ? nil : in_color(:blue) { "#{prefix[:request]}  " }
          http_request_log  = in_color(request_log_color(env.method)) { "#{env.method.upcase} #{apply_filters(env.url.to_s)}" }

          request_log = proc { "#{' ' * prefix[:indent]}#{http_request_term}#{http_request_log}" }
          public_send(log_level, &request_log)

          log_headers(nil, env.request_headers) if log_headers?(:request)
          log_body(nil, env[:body]) if env[:body] && log_body?(:request)
        end

        def response(env)
          http_response_term = (prefix[:response].nil? || prefix[:response].strip.empty?) ? nil : in_color(:blue) { "#{prefix[:response]}  " }
          http_response_log  = in_color(response_log_color(env.status)) { "Status #{env.status}" }

          status = proc { "#{' ' * prefix[:indent]}#{http_response_term}#{http_response_log}" }
          public_send(log_level, &status)

          log_headers(nil, env.response_headers) if log_headers?(:response)
          log_body(nil, env[:body]) if env[:body] && log_body?(:response)
        end

        private

        attr_reader :prefix

        def in_color(color)
          "#{ANSI_COLORS[color]}#{yield}#{ANSI_COLORS[:reset]}"
        end

        def request_log_color(request_method)
          case request_method
          when :post
            :green
          when :put, :patch
            :yellow
          when :delete
            :red
          else
            :blue
          end
        end

        def response_log_color(response_status)
          case response_status
          when 100..199
            :blue
          when 200..299
            :green
          when 300..399
            :yellow
          when 400..599
            :red
          end
        end
      end
    end
  end
end
