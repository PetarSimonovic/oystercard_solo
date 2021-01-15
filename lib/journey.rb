class Journey

  FINE = 6

  attr_reader :in_transit, :journey_start, :journey_end, :history

  def initialize
    @journey_start = {}
    @journey_end = {}
    @in_transit = false
    @exit_station = nil
    @end_zone = nil
    @history = []
  end

  def start(entry_station, start_zone)
    @in_transit = true
    @journey_start = {
      :entry_station => entry_station,
      :start_zone => start_zone
    }
  end

  def finish(exit_station, end_zone)
    @in_transit = false
    @journey_end = {
      :exit_station => exit_station,
      :end_zone => end_zone
    }

    @history << journey_start.merge(journey_end)
  end

  def in_journey?
    @in_transit
  end

  def penalty
    FINE
  end

  def incomplete_journey
    finish("no station", 0)
  end

end
