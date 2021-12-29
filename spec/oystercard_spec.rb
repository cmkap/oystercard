require 'oystercard'

describe Oystercard do
    
    
    # check if Oystercard has all the methods
    it { is_expected.to respond_to(:top_up, :touch_out).with(1).argument}
    it { is_expected.to respond_to(:touch_in, :entry_station, :exit_station, :balance, :journeys)}
    it { is_expected.not_to respond_to(:deduct) }
    
    let(:card) { Oystercard.new } # at this stage card does not exist it only saves a block to execute when card is called
    let(:exit_station) { double :station }
    let(:entry_station) { double :station }


   
    context 'at start-up'do
        it 'sets balance to 0' do 
            expect(card.balance).to eq 0
        end 
    end

    describe '#top_up' do
        it 'adds 5 to balance' do 
            expect { card.top_up(5) }.to change(card, :balance).by(5)
        end 

        it 'adds 90 to balance' do
            expect(card.top_up(90)).to eq 90
        end 
    end   
    
    describe '#top_up' do
        context "when balance is above limit" do
            it 'returns error' do
                card.top_up(90)
                expect{card.top_up(5)}.to raise_error("Balance cannot exceed £#{Oystercard::LIMIT}.")
            end 
        end
    end


    describe '#touch_in' do
        context 'when balance is 0' do
            it 'throws an error' do
                expect { card.touch_in(entry_station) }.to raise_error "Insufficient balance."
            end
        end
    end 

   

    context 'when in journey' do
        


        describe '#touch_out' do
    
            it 'sets entry_station to nil' do
                #Arrange
                card.top_up(10)
                #act
                card.touch_in(entry_station)
                card.touch_out(exit_station)
                #assert
                expect(card.entry_station).to eq nil
            end
    
            it 'deducts minimum fare' do
                #Arrange
                # create a scenario
                card.top_up(10)
                card.touch_in(entry_station)
                #Assert (here act is card.touch_in)
                expect { card.touch_out(exit_station) }.to change(card, :balance).by(-Oystercard::MINIMUM_FARE )
            end
        end 


        describe '#journeys' do
        
            it 'stores the journey when touched out' do
                card.top_up(10)
                card.touch_in(entry_station)
                card.touch_out(exit_station)
                expect(card.journeys).to include(a_kind_of(Journey))
            end

            it 'stores an empty list of journeys by default' do
                card.top_up(10)
                expect(card.journeys.empty?).to eq(true)
            end

        end

    end
end

