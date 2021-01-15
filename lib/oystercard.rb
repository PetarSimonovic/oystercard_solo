class Oystercard

  CARD_LIMIT = 90

  attr_reader :balance, :journey

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    fail "Balance limit of £#{CARD_LIMIT} exceeded" if limit_exceeded?(amount)

    @balance += 5
  end

  def deduct(amount)
    @balance -= 5
  end

  def limit_exceeded?(amount)
    @balance + amount > CARD_LIMIT
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end 

  def in_journey?
    @journey
  end

end
