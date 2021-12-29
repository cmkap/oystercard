require_relative './journey'
require_relative './station'

class Oystercard
    attr_reader :balance, :entry_station, :exit_station, :journeys

    LIMIT = 90
    MINIMUM_FARE = 1
    

    def initialize(balance = 0)
        @balance = balance
        @journey = Journey.new
        @journeys = []
    end

    def top_up(amount)
        (@balance + amount) > LIMIT ? fail("Balance cannot exceed £#{LIMIT}.") : @balance += amount
    end 

    
    def touch_in(station)
        raise "Insufficient balance." unless @balance >= MINIMUM_FARE
        @journey.start(station)
    end 
    
    def touch_out(station)
        @journeys << @journey.finish(station)
        deduct(@journey.fare)
    end
    
    # def in_journey?    
    #     !!entry_station
    # end 
    

    private
    
    def deduct(fare)
        @balance -= fare
    end

end

