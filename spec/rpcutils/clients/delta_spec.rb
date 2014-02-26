require 'spec_helper'
require 'rpcutils/clients/delta'

describe 'RpcUtils::Clients::Delta' do
  describe 'config' do
    it 'loads defaults from yaml correctly' do
      yml = File.expand_path('../../../../config/clients.yml', __FILE__)
      conf = YAML.load_file(yml)
      d = RpcUtils::Clients::Delta.new
      d.host.should == conf['delta']['host']
      d.port.should == conf['delta']['port']
    end
  end
end
