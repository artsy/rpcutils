require 'yaml'

module RpcUtils
  module Clients
    class Base
      attr_accessor :host, :port, :conf

      def initialize(opts = {})
        @@defaults ||= load_defaults
        raise ValueError, 'Please add client defaults to config file.' unless config.size
        @host = opts.fetch(:host, config[:host])
        @port = opts.fetch(:port, config[:port])
        @protocol = opts.fetch(:protocol, config.fetch(:protocol, 'http'))
      end

      # generic rpc method call.
      def call(method, opts = {})
        opts[:method] = method.to_s
        request = get_request(opts)
        send_request(request)
        response = request.response

        if response.success?
          response
        else
          raise error_string_for(response)
        end

        JSON.parse response.body
      end

      def base_url
        url = "#{@protocol}://#{@host}"
        url += ":#{@port}" if @port
        url
      end

      protected

      def get_request(opts)
        Typhoeus::Request.new(base_url + "/?" + opts.to_query)
      end

      def send_request(request)
        hydra = Typhoeus::Hydra.hydra
        hydra.queue(request)
        hydra.run
      end

      def load_defaults
        yml = File.expand_path('../../../../config/clients.yml', __FILE__)
        YAML.load_file(yml)
      end

      def config
        @conf ||= @@defaults.fetch(self.class.name.downcase.split('::').last, {}).symbolize_keys!
      end

      def error_string_for(response)
        if response.timed_out?
          "Request timed out"
        elsif response.code == 0
          "Service could not be reached"
        else
          "Error (#{response.code}): #{response.body}"
        end
      end
    end
  end
end
