require 'json'
require 'typhoeus'
require_relative './base'

module RpcUtils
  module Clients
    class Delta < Base

      # send an event to delta service.
      def send(event)
        request = Typhoeus::Request.new(base_url + '/event', body: serialize(event))
        send_request(request)
      end

      # fetch all trending artists.
      def get_trending_artists(opts = {})
        opts[:n] = opts.fetch(:n, 100)
        request = Typhoeus::Request.new(base_url + "/artists?" + opts.to_query)
        send_request(request)
        response = request.response

        if response.success?
          response
        else
          raise error_string_for(response)
        end

        JSON.parse response.body
      end

      def serialize
        event.to_json
      end

      def base_url
        url = "http://#{@host}"
        url += ":#{@port}" if @port
        url
      end

      private

      def error_string_for(response)
        if response.timed_out?
          "Request to Delta timed out"
        elsif response.code == 0
          "Delta could not be reached"
        else
          "Received #{response.code} error from Delta: #{response.body}"
        end
      end

      # fire and forget this request.
      def send_request(request)
        hydra = Typhoeus::Hydra.hydra
        hydra.queue(request)
        hydra.run
      end
    end
  end
end
