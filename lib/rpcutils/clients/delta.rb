require 'json'
require 'typhoeus'
require_relative './base'

module RpcUtils
  module Clients
    class Delta < Base
      # emit an event to delta service.
      # fire and forget.
      def emit(event)
        request = Typhoeus::Request.new(base_url + '/event', method: :post, body: serialize(event))
        send_request(request)
      end

      # fetch all trending artists.
      def get_trending_artists(opts = {})
        call(:get_trending_artists, opts)
      end

      def serialize(event)
        event.to_json
      end
    end
  end
end
