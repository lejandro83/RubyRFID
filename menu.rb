require_relative 'db_setup'

PORT_PATH = "/dev/tty.usbmodem1411"
require_relative 'port'
$port = Port.instance


puts "What do you want to do?"
puts "\t1 - Add new card"
puts "\t2 - Add funds to card"
puts "\t3 - Pay toll"
puts "\t4 - Replace card"
puts "\t5 - Exit"
app_status = gets

case app_status.chomp
  when "1"
    # read card
  else
    p 'Bye!'
end


def find_card

end


