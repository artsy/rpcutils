require 'spec_helper'
require 'rpcutils/clients/delta'

describe 'RpcUtils::Clients::Delta' do
  describe 'config' do
      it 'can have port and host configured' do
        d = RpcUtils::Clients::Delta.new(host: 'testhost', port: 80)
        d.host.should == 'testhost'
        d.port.should == 80
      end
    end

  describe 'request builder' do
    it 'builds base url correctly' do
      d = RpcUtils::Clients::Delta.new(host: 'testhost', port: 80)
      d.base_url.should == 'http://testhost:80'
    end
  end
end
