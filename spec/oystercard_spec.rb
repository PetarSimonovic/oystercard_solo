require 'oystercard'

describe Oystercard do

  let(:topped_up_card) { Oystercard.new(Oystercard::CARD_LIMIT) }


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
      expect{ subject.touch_in }.to raise_error if "Balance is too low"
    end

  end

  describe "#touch_out" do

    it "touch_out deducts the minimum fare" do
      expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

  end

    describe "#journey" do

      context "it should touch_in before journey" do

        before do
          topped_up_card.touch_in
        end

        it "should be in_journey after touch_in" do
          expect(topped_up_card).to be_in_journey
        end

        it "should not be in_journey after touch_out" do
          topped_up_card.touch_out
          expect(topped_up_card).not_to be_in_journey
        end

      end

    end

end
