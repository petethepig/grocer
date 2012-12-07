module Grocer
  class Reply
    LENGTH = 6

    STATUS_CODES={
      0   => "No errors encountered",
      1   => "Processing error",
      2   => "Missing device token",
      3   => "Missing topic",
      4   => "Missing payload",
      5   => "Invalid token size",
      6   => "Invalid topic size",
      7   => "Invalid payload size",
      8   => "Invalid token",
      255 => "None (unknown)"
    }

    attr_accessor :identifier, :command, :status

    def initialize(binary_tuple)
      # C   =>  1 byte command
      # C   =>  1 byte status
      # N   =>  4 byte identifier
      @command, @status, @identifier = binary_tuple.unpack("CCN")
      raise InvalidFormatError unless @command && @status && @identifier
    end
    def to_s
      { 
        status: STATUS_CODES[@status],
        command: @command,
        identifier: @identifier
      }.to_s
    end

  end
end
