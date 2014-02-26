require 'spec_helper'
require 'rpcutils/clients/delta'

describe 'RpcUtils::Clients::Base' do
  before(:each) do
    RpcUtils::Clients::Base.any_instance.stub(:load_defaults) {}
    RpcUtils::Clients::Base.any_instance.stub(:config) { { host: 'localhost', port: 666 } }
  end
  describe 'configuration' do
    it 'loads correctly' do
      client = RpcUtils::Clients::Base.new
      client.host.should == 'localhost'
      client.port.should == 666
    end

    it 'can have port and host customised' do
      client = RpcUtils::Clients::Base.new(host: 'testhost', port: 80)
      client.host.should == 'testhost'
      client.port.should == 80
    end
  end

  describe 'request builder' do
    it 'builds base url correctly' do
      client = RpcUtils::Clients::Base.new(host: 'testhost', port: 80)
      client.base_url.should == 'http://testhost:80'
    end
  end

  describe 'rpc execution' do
    it 'sends requests correctly using call method' do
      request = double
      response = double
      rsp = JSON.generate(rsp: 1)
      request.should_receive(:response).and_return(response)
      response.should_receive(:success?).and_return(true)
      response.should_receive(:body).and_return(rsp)
      Typhoeus::Request.should_receive(:new).with('http://localhost:666/?method=foo&param1=blah') { request }
      client = RpcUtils::Clients::Base.new
      client.should_receive(:send_request).with(request) {}
      client.call('foo', param1: 'blah').should == JSON.parse(rsp)
    end
  end
end
