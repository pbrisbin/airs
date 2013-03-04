require 'spec_helper'
require 'fakeweb'

module Airs
  describe NextEpisode do
    before { FakeWeb.allow_net_connect = false }
    after  { FakeWeb.clean_registry }

    it "downloads todays titles from next-episode" do
      file    = File.expand_path('../../files/next-episode.html', __FILE__)
      content = File.read(file)

      FakeWeb.register_uri(:get, 'http://next-episode.net', :body => content)

      subject.todays_titles.should =~ ["90210", "Forum", "Adventure Time",
        "Forum", "Alaska State Troopers", "American Pickers",
        "Bang Goes the Theory", "Being Human (US)", "Forum",
        "Bizarre Foods with Andrew Zimmern", "Bones", "Forum", "Broadchurch",
        "Burning Love", "Chelsea Lately", "Conan", "Forum", "Dallas (2012)",
        "Dancing on Ice", "Deception", "Eastenders", "Embarrassing Bodies",
        "Fast 'n' Loud", "Fifth Gear", "Home and Away", "House of Anubis",
        "Inside Comedy", "Jerseylicious", "Lab Rats (2012)",
        "Lizard Lick Towing", "Monday Mornings", "Neighbours", "Pawn Stars",
        "Pawn Stars", "Robson's Extreme Fishing Challenge",
        "Rules of Engagement", "RuPaul's Drag Race", "Shaun the Sheep",
        "Swamp Hunters", "Switched at Birth", "Forum", "Teen Mom 2",
        "The Bachelor", "The Biggest Loser", "The Bold and the Beautiful",
        "The Carrie Diaries", "The Colbert Report", "The Daily Show",
        "The Ellen DeGeneres Show", "The Following", "The Murdoch Mysteries",
        "The Real Housewives of Beverly Hills", "Vanderpump Rules"]
    end
  end
end

