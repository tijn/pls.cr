module Pls
  # https://en.wikipedia.org/wiki/PLS_(file_format)
  class Entry
    @length : String

    def initialize(@file : String, @title : String | Nil, length : String | Nil)
      @length = length.to_s
    end

    def to_s(io : IO)
      io << "File:   " << @file << "\n"
      io << "Title:  " << @title << "\n" unless @title.nil?
      io << "Length: " << human_length << "\n" unless @length.empty?
    end

    def human_length
      return "length unknown" if @length.empty?

      seconds = @length.to_i
      return "stream" if seconds < 0
      return "#{seconds} s" unless seconds > 59

      minutes, seconds = seconds.divmod(60)
      return "#{minutes}:#{seconds}" unless minutes > 59

      hours, minutes = minutes.divmod(60)
      return "#{hours}:#{minutes}:#{seconds}" unless hours > 24

      days, hours = hours.divmod(24)
      return "#{days} day(s) #{hours}:#{minutes}:#{seconds}"
    end
  end
end
