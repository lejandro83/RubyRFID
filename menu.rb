require_relative 'back_office'
require_relative 'db_setup'
require_relative 'card'

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
    BackOffice.add_registry
  when "2"
    BackOffice.add_founds
  when "3"
    BackOffice.pay_toll
  when "4"
    BackOffice.change_card_id
  else
    p 'Bye!'
    $port.close_port
end




