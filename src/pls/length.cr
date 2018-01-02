module PLS
  class Length
    class Stream
      # Returns -1.
      def to_i
        -1
      end

      # Returns "stream".
      def to_s(io : IO)
        io << "stream"
      end

      # Returns "-1".
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

      # Returns the time span in seconds.
      def to_i
        @span.to_i
      end

      # Converts to `String`.
      def to_s(io : IO)
        io << @span
      end

      # Returns the time span in seconds as a `String`.
      def to_pls(io : IO)
        io << to_i
      end
    end

    # Parse a length. In PLS a length is either a magic value "-1", which means that it is a stream, or a timespan in seconds.
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
