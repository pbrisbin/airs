require 'spec_helper'
require 'webmock/rspec'

module Airs
  describe Main do
    before do
      file    = File.expand_path('../files/next-episode.html', __FILE__)
      content = File.read(file)

      stub_request(:get, 'http://next-episode.net').to_return(:body => content)

      ENV['PUSHOVER_USER'] = 'User key'
    end

    it "should notify via pushover for shows we watch" do
      pushover = double("Pushover")
      pushover.should_receive(:notify).with('User key', 'Airs today: American Pickers, Eastenders')
      Pushover.should_receive(:new).with(Main::PUSHOVER_TOKEN).and_return(pushover)

      subject.run("american pickers\neastenders\n")
    end

  end
end
