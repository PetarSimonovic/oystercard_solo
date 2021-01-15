require 'station'

describe Station do

  let(:station) {Station.new("London Bridge", 1)}

  describe "#initialize" do

    it "initialises with station_name" do
      expect(station.station_name).to eq("London Bridge")
    end

    it "initializes with a zone" do
      expect(station.zone).to eq(1)
    end 

  end

end
