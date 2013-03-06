require 'spec_helper'
require 'webmock/rspec'

module Airs
  describe Pushover do
    subject { Pushover.new("API token") }

    it "sends pushes to pushover.net" do
      body = {
        user:    'User key',
        token:   'API token',
        message: 'A message'
      }

      req = stub_request(:post, Pushover::API).with(body: body)

      subject.notify('User key', 'A message')

      req.should have_been_requested
    end
  end
end
