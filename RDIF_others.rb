require 'serialport'
require 'active_record'
require 'sqlite3'

port_str = "/dev/tty.usbmodem1421" # Serialport mount point
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = 0 # SerialPort::NONE

port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

while barcode = port.gets do
  puts barcode
end

port.close


ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.colorize_logging = false
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :dbfile  => ":memory:"
)
ActiveRecord::Schema.define do
  create_table :cards do |table|
    table.column :card_id, :string
    table.column :user_name, :string
    table.column :balance, :double
  end
end
class Cards < ActiveRecord::Base
  # 
end

Card.create(:card_id => 'XXXXX',
    :user_name => 'Pepito',
    :balance => 0)

puts Card.find_by_card_id('XXXX').balance
card = Card.find_by_card_id('XXXX').card_id
card.balance = 10
card.save
puts Card.find_by_card_id('XXXX').balance

# require "libusb"
# usb = LIBUSB::Context.new
# device = usb.devices(:idVendor => 0x08ff, :idProduct => 0x0009).first
# device.open_interface(0) do |handle| 
#   handle.control_transfer(:bmRequestType => 0x40, :bRequest => 0xa0, :wValue => 0xe600, :wIndex => 0x0000, :dataOut => 1.chr)
# end

# device.open.pHandle.get_uint16(0)
# require "ffi"
# vendor_id = 0x08ff
# product_id = 0x0009
# serial_number = 'CC2E1M0DPPDG6LL0'
# device = HidApi.hid_open(vendor_id, product_id, serial_number)

# device.usb_control_msg()


# def usb_control_msg(requesttype, request, value, index, bytes, timeout)
#   if requesttype&LIBUSB::ENDPOINT_IN != 0
#     # transfer direction in
#     res = @dev.control_transfer(:bmRequestType=>requesttype, :bRequest=>request,
#         :wValue=>value, :wIndex=>index, :dataIn=>bytes.bytesize, :timeout=>timeout)
#     bytes[0, res.bytesize] = res
#     res.bytesize
#   else
#     # transfer direction out
#     @dev.control_transfer(:bmRequestType=>requesttype, :bRequest=>request, :wValue=>value,
#         :wIndex=>index, :dataOut=>bytes, :timeout=>timeout)
#   end
# end

# //////////////
# require 'ffi'
 
# module HidApi
#   extend FFI::Library
#   ffi_lib '/Users/libtool'
 
#   attach_function :hid_open, [:int, :int, :int], :pointer
#   # attach_function :hid_write, [:pointer, :pointer, :int], :int
#   attach_function :hid_read_timeout, [:pointer, :pointer, :int, :int], :int
#   attach_function :hid_close, [:pointer], :void
 
#   REPORT_SIZE = 65 # 64 bytes + 1 byte for report type
#   def self.pad_to_report_size(bytes)
#     (bytes+[0]*(REPORT_SIZE-bytes.size)).pack("C*")
#   end
# end
 
# # USAGE
 
# # CONNECT
# vendor_id = 0x08ff
# product_id = 0x0009
# serial_number = 'CC2E1M0DPPDG6LL0'
# device = HidApi.hid_open(vendor_id, product_id, serial_number)
 
# # SEND
# # command_to_send = HidApi.pad_to_report_size([0]+ARGV.map(&:hex)).pack("C*")
# # res = HidApi.hid_write dev, command_to_send, HidApi::REPORT_SIZE
# # raise "command write failed" if res <= 0
 
# # READ
# buffer = FFI::Buffer.new(:char, HidApi::REPORT_SIZE)
# res = HidApi.hid_read_timeout device, buffer, HidApi::REPORT_SIZE, 1000
# raise "command read failed" if res <= 0
# p buffer.read_bytes(HidApi::REPORT_SIZE).unpack("C*")
