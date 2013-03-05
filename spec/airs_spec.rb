require 'spec_helper'

module Airs
  describe Main do
    def run(patterns)
      subject.run(patterns.join("\n"))
    end

    before do
      subject.stub(:puts)

      source = double("Next episode source",
                      :todays_titles => %w( Foo Biz Bar Buz Baz ))

      NextEpisode.stub(:new).and_return(source)
    end

    it "should push when shows are airing" do
      push = double("Push")
      push.should_receive(:send!)

      Push.should_receive(:new).with("Airs today: Foo, Bar, Baz").and_return(push)

      run %w( foo ba.* )
    end

    it "should not push when shows aren't airing" do
      Push.should_not_receive(:new)

      run %w( flim flam )
    end
  end
end
