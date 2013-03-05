require 'spec_helper'

module Airs
  describe WatchList do
    it "should hold and match string patterns" do
      subject << "foo.*bar"
      subject << "baz bat$"

      subject.match?("Foo and Bar").should be_true
      subject.match?("The Baz Bat").should be_true

      subject.match?("Biz Buz").should be_false
      subject.match?("The Baz Bat 2").should be_false
    end

    it "should handle odd quoting" do
      subject << "That's All Folks"
      subject << 'Hey, "What"'

      subject.match?("That's All Folks").should be_true
      subject.match?('Hey, "What"').should be_true
    end
  end
end
