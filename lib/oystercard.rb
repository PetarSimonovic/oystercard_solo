class Oystercard

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey

  def initialize(balance = 0)
    @balance = balance
    @journey = false
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

  def touch_in
    fail "Balance is too low" if @balance < MINIMUM_FARE

    @journey = true
  end

  def touch_out
    @journey = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @journey
  end

end
