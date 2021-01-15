class Oystercard

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :in_transit, :journey

  def initialize(balance = 0)
    @balance = balance
    @in_transit = false
    @journey = {}
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

    @in_transit = true
    @journey[:entry_station] = station
  end

  def touch_out
    @in_transit = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_transit
  end

end
