require 'spec_helper'

module Airs
  describe WatchList do
    it "should hold and match string patterns" do
      list = WatchList.new("foo.*bar\nbaz bat$\n")

      list.match?("Foo and Bar").should be_true
      list.match?("The Baz Bat").should be_true

      list.match?("Biz Buz").should be_false
      list.match?("The Baz Bat 2").should be_false
    end

    it "should handle odd quoting" do
      list = WatchList.new("That's It\nHey \"What\"\n")

      list.match?("That's It").should be_true
      list.match?('Hey "What"').should be_true
    end
  end
end
