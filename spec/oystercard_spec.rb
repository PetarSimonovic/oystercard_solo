require 'oystercard'
require 'Station'

describe Oystercard do

  let(:topped_up_card) { Oystercard.new(Oystercard::CARD_LIMIT) }
  let(:entry_station) { Station.new("London Bridge", 2) }
  let(:exit_station) { double :station }
  let(:start_zone) { double :zone }
  let(:end_zone) { double :zone }



  describe '#initialize' do

    it { is_expected.to respond_to(:balance) }


    it "has a balance of zero unless specified" do
      expect(subject.balance).to eq 0
    end

  end

  describe '#top_up' do

    it {is_expected.to respond_to(:top_up).with(1).argument }

    it "should add amount to the balance" do
      expect{ subject.top_up(5)}.to change{ subject.balance }.by(5)
    end

    it "raises an exception when the maximum balance is exceeded" do
      expect{ subject.top_up(91) }.to raise_error "Balance limit of £#{Oystercard::CARD_LIMIT} exceeded"
    end

  end

  describe "#deduct" do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    context "it should top_up before deduct" do

      before do
        subject.top_up(10)
      end

      it "should deduct amount from balance" do
        expect{ subject.deduct(5)}.to change{ subject.balance }.by(-5)
      end

    end

  end

  describe "#touch_in" do

    it { is_expected.to respond_to(:touch_in) }

    it "cannot touch_in unless it has the minimum fare" do
      expect{ subject.touch_in(station, zone) }.to raise_error if "Balance is too low"
    end

    it "applies a penalty if card is touched in twice in a row" do
      topped_up_card.touch_in(entry_station)
      expect{ topped_up_card.touch_in(entry_station) }.to change{ topped_up_card.balance }.by(-6)
    end

  end

  describe "#touch_out" do

    # it "deducts the minimum fare" do
    #   expect{ subject.touch_out(:exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    # end
    #
    # it "should remember the exit_station" do
    #   topped_up_card.touch_out(:exit_station)
    #   expect(topped_up_card.journey).to include(:exit_station => :exit_station)
    # end
    # #
    # it "should save a history of all journeys" do
    #   topped_up_card.touch_in(:entry_station, :start_zone)
    #   topped_up_card.touch_out(:exit_station, :end_zone)
    #   expect(topped_up_card.journey_history).to include(topped_up_card.journey)
    # end

  end

end
