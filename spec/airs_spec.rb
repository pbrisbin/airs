require 'spec_helper'

module Airs
  describe Main do
    before do
      source = double("Next episode source")
      source.stub(:todays_titles).and_return([
        "Foo", "Biz", "Bar", "Buz", "Baz"
      ])

      NextEpisode.stub(:new).and_return(source)
    end

    it "should push when shows are airing" do
      push = double("Push", :send! => true)

      Push.should_receive(:new).with("Airs today: Foo, Bar, Baz").and_return(push)

      subject.run(["foo", "ba.*"].join("\n"))
    end

    it "should not push when shows aren't airing" do
      Push.should_not_receive(:new)

      subject.run(["flim", "flam"].join("\n"))
    end
  end
end
