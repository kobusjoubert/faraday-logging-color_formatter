# frozen_string_literal: true

require 'faraday'

module Faraday
  module Logging
    module ColorFormatter
      class Formatter < Faraday::Logging::Formatter
        ANSI_COLORS = { red: "\e[31m", green: "\e[32m", yellow: "\e[33m", blue: "\e[34m", magenta: "\e[35m", cyan: "\e[36m", reset: "\e[0m" }.freeze

        def request(env)
          http_request_term = "#{ANSI_COLORS[:blue]}HTTP Request#{ANSI_COLORS[:reset]}"

          request_log = proc { "#{request_log_color(env.method)}#{env.method.upcase} #{apply_filters(env.url.to_s)}#{ANSI_COLORS[:reset]}" }
          public_send(log_level, http_request_term, &request_log)

          log_headers(http_request_term, env.request_headers) if log_headers?(:request)
          log_body(http_request_term, env[:body]) if env[:body] && log_body?(:request)
        end

        def response(env)
          http_response_term = "#{ANSI_COLORS[:blue]}HTTP Response#{ANSI_COLORS[:reset]}"

          status = proc { "#{response_log_color(env.status)}Status #{env.status}#{ANSI_COLORS[:reset]}" }
          public_send(log_level, http_response_term, &status)

          log_headers(http_response_term, env.response_headers) if log_headers?(:response)
          log_body(http_response_term, env[:body]) if env[:body] && log_body?(:response)
        end

        private

        def request_log_color(request_method)
          case request_method
          when :post
            ANSI_COLORS[:green]
          when :put, :patch
            ANSI_COLORS[:yellow]
          when :delete
            ANSI_COLORS[:red]
          else
            ANSI_COLORS[:blue]
          end
        end

        def response_log_color(response_status)
          case response_status
          when 100..199
            ANSI_COLORS[:blue]
          when 200..299
            ANSI_COLORS[:green]
          when 300..399
            ANSI_COLORS[:yellow]
          when 400..599
            ANSI_COLORS[:red]
          end
        end
      end
    end
  end
end
