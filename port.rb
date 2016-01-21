require 'singleton'
require 'serialport'

class Port
  include Singleton

  BAUD_RATE = 9600
  DATA_BITS = 8
  STOP_BITS = 1
  PARITY = 0

  attr_accessor :device, :raw_input

  def initialize
    self.device = SerialPort.new(PORT_PATH, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)
  end

  def scan
    @raw_input = nil
    loop do
      @raw_input = self.device.gets

      if @raw_input.include?('UID:')
        self.device.close
        break
      end
    end
    return self.strip_uid
  end

  def strip_uid
    @raw_input.gsub("\r\n", "").gsub("UID: ", "")
  end
end