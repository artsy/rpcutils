require 'yaml'

module RpcUtils
  module Clients
    class Base
      attr_accessor :host, :port

      @@defaults = {}

      def initialize(opts = {})
        @@defaults = load_defaults
        @host = opts.fetch(:host, @@defaults['host'])
        @port = opts.fetch(:port, @@defaults['port'])
      end

      def load_defaults
        return @@defaults if @@defaults.any?
        yml = File.expand_path('../../../../config/clients.yml', __FILE__)
        conf = YAML.load_file(yml)
        name = self.class.name.downcase.split('::').last
        conf.fetch(name, {})
      end
    end
  end
end
