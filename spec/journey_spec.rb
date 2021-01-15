require 'journey'
require 'station'

describe Journey do

  let(:journey) { Journey.new }

  it "should know when it's in transit" do
    journey.start("London Bridge", 1)
    expect(journey).to be_in_journey
  end

  it "should end a journey" do
    journey.finish("Forest Hill", 2)
    expect(journey).not_to be_in_journey
  end

  it "records starting station and zone" do
    journey.start("London Bridge", 1)
    expect(journey.journey_start).to include({ :entry_station => "London Bridge", :start_zone => 1} )
  end

  it "records exit_station and end_zone" do
    journey.finish("Forest Hill", 2)
    expect(journey.journey_end).to include({ :exit_station => "Forest Hill", :end_zone => 2} )
  end

  it "creates a record of a complete journey" do
    journey.start("London Bridge", 1)
    journey.finish("Forest Hill", 2)
    expect(journey.history).to include( { :entry_station => "London Bridge", :start_zone => 1, :exit_station => "Forest Hill", :end_zone => 2 })
   end

end
