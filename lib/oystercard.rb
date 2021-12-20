class Oystercard
    attr_reader :balance, :entry_station

    LIMIT = 90
    MINIMUM_FARE = 1
    def initialize(balance = 0)
        @balance = balance
    
        @entry_station = nil
    end

    def top_up(amount)
        (@balance + amount) > LIMIT ? fail("Balance cannot exceed £#{LIMIT}.") : @balance += amount
    end 

    
    def touch_in(station)
        raise "Insufficient balance." unless @balance >= MINIMUM_FARE
        @entry_station = station
    end 
    
    def touch_out
        deduct(MINIMUM_FARE)
        @entry_station = nil
    end
    
    def in_journey?    
        !!entry_station
    end 
    

    private
    
    def deduct(amount)
        @balance -= amount
    end

end

# GOAL - we wanna save the entry station
# Where doo we get the station? "station"
# Where do we store the station? @entry_station
# at touch_in set @entry_station to "station"
# at touch_out set @entry_station to nil
# What is our double?

# Goal - refactor in_journey 
# in_journey relies on entry station

# !!nil   #=> false
# !!"abc" #=> true
# !!false #=> false