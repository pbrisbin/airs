require 'spec_helper'
require 'webmock/rspec'

module Airs
  describe Push do
    it "sends pushes to pushover.net" do
      ENV['PUSHOVER_USER'] = 'ENV_USER'

      body = {
        user:    'ENV_USER',
        token:   Push::TOKEN,
        message: "A message"
      }

      req = stub_request(:post, Push::URL).with(body: body)

      push = Push.new("A message")
      push.send!

      req.should have_been_requested
    end
  end
end
