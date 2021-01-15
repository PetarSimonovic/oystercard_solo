require_relative 'station'
require_relative 'journey'

class Oystercard

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey
  attr_accessor :journey_history

  def initialize(balance = 0)
    @balance = balance
    @journey = Journey.new
    @journey_history = []
  end

  def top_up(amount)
    fail "Balance limit of £#{CARD_LIMIT} exceeded" if limit_exceeded?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def limit_exceeded?(amount)
    @balance + amount > CARD_LIMIT
  end

  def touch_in(station)
    fail "Balance is too low" if @balance < MINIMUM_FARE
    # check_penalty
    @journey.start(station.station_name, station.zone)
  end

  # def check_penalty
  #   return unless @journey.in_transit == true
  #
  #   @balance -= @journey.touch_in_penalty
  #   puts "Penalty applied: new balance is #{@balance}"
  # end

  def touch_out(station)
    # @in_transit = false
    # deduct(MINIMUM_FARE)
    @journey.end(station.station_name, station.zone)
    journey_history.push @journey.journey_start.merge(@journey.journey_end)
  end


end
