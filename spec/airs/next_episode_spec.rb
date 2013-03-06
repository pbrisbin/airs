require 'spec_helper'
require 'webmock/rspec'

module Airs
  describe NextEpisode do
    before do
      file    = File.expand_path('../../files/next-episode.html', __FILE__)
      content = File.read(file)

      stub_request(:get, 'http://next-episode.net').to_return(:body => content)
    end

    it "returns any of todays titles matched by the watchlist" do
      list   = stub("Watchlist", :match? => true)
      source = NextEpisode.new(list)

      source.airs_today.should =~ ["90210", "Adventure Time",
        "Alaska State Troopers", "American Pickers", "Bang Goes the Theory",
        "Being Human (US)", "Bizarre Foods with Andrew Zimmern", "Bones",
        "Broadchurch", "Burning Love", "Chelsea Lately", "Conan",
        "Dallas (2012)", "Dancing on Ice", "Deception", "Eastenders",
        "Embarrassing Bodies", "Fast 'n' Loud", "Fifth Gear", "Forum",
        "Home and Away", "House of Anubis", "Inside Comedy", "Jerseylicious",
        "Lab Rats (2012)", "Lizard Lick Towing", "Monday Mornings",
        "Neighbours", "Pawn Stars", "Robson's Extreme Fishing Challenge",
        "RuPaul's Drag Race", "Rules of Engagement", "Shaun the Sheep",
        "Swamp Hunters", "Switched at Birth", "Teen Mom 2", "The Bachelor",
        "The Biggest Loser", "The Bold and the Beautiful",
        "The Carrie Diaries", "The Colbert Report", "The Daily Show",
        "The Ellen DeGeneres Show", "The Following", "The Murdoch Mysteries",
        "The Real Housewives of Beverly Hills", "Vanderpump Rules"]

      list.stub(:match?).and_return(false)

      source.airs_today.should be_empty
    end
  end
end
