
class BusBoard
  attr_reader :bus_stop

  def start
    puts 'Intput the bus stop code you want to check'
    @bus_stop = gets.chomp
    request_api
  end

  def request_api

  end
end



bus_board = BusBoard.new

bus_board.start