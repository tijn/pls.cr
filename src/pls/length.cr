module Pls
  class Length
    class Stream
      def to_i
        -1
      end

      def to_s(io : IO)
        io << "stream"
      end

      def to_pls(io : IO)
        io << "-1"
      end
    end

    # The Span class is just a wrapper around a Time::Span. It only exists to guarantee immutability and to prevent negative timespans.
    class Span
      def initialize(seconds : Int32)
        raise ArgumentError.new("negative length") if seconds < 0
        @span = Time::Span.new(0, 0, seconds)
      end

      def to_i
        @span.to_i
      end

      def to_s(io : IO)
        io << @span
      end

      def to_pls(io : IO)
        io << "#{to_i}"
      end
    end

    # a length in PLS is either a magic value "-1", which means that it is a stream or a timespan in seconds.
    def self.parse(string : String)
      case string
      when "-1"
        Stream.new
      else
        Span.new(string.to_i)
      end
    end
  end
end
