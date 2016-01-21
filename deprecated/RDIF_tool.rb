require 'serialport'
require 'active_record'
require 'sqlite3'



port_str = "/dev/tty.usbmodem1421" # Serialport mount point
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = 0 # SerialPort::NONE

port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

# while barcode = port.gets do
  puts port.gets
# end

port.close

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :dbfile  => ":memory:",
  :database => "RFID"
)
class Card < ActiveRecord::Base
end

Card.create(:card_id => 'XXXXX',
    :user_name => 'Pepito',
    :balance => 0)

puts Card.find_by_card_id('XXXX').balance
card = Card.find_by_card_id('XXXX').card_id
card.balance = 10
card.save
puts Card.find_by_card_id('XXXX').balance



class SerialReader
  attr_accessor
  port_str = "/dev/tty.usbmodem1421" # Serialport mount point
  baud_rate = 9600
  data_bits = 8
  stop_bits = 1
  parity = 0 # SerialPort::NONE
  port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

  def start_read
    port.gets
  end
end
