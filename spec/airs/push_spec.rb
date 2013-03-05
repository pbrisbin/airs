require 'spec_helper'

module Airs
  describe Push do
    # TODO: I don't want to Mock Net:HTTP (I don't own it), Fakeweb
    # can't handle POST bodies, and I don't want to hit real internet...
    it "sends pushes to pushover.net"
  end
end
