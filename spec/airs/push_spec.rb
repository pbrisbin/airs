require 'spec_helper'
require 'fakeweb'

module Airs
  describe Push do
    before { FakeWeb.allow_net_connect = false }
    after  { FakeWeb.clean_registry }

    subject { Push.new("Some message") }

    before do
      ENV['PUSHOVER_USER']  = 'ENV_USER'
      ENV['PUSHOVER_TOKEN'] = 'ENV_TOKEN'
    end

    it "POSTs to pushover.net" do
      # FIXME: mocking what i don't own...
      Curl::PostField.should_receive(:content).with('user',    'ENV_USER').and_return('field 1')
      Curl::PostField.should_receive(:content).with('token',   'ENV_TOKEN').and_return('field 2')
      Curl::PostField.should_receive(:content).with('message', 'Some message').and_return('field 3')
      Curl::Easy.should_receive(:http_post).with('https://api.pushover.net/1/messages', 'field 1', 'field 2', 'field 3')

      subject.send!
    end
  end
end
