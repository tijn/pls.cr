module Pls
  class Entry
    def initialize(@file : String, @title : String | Nil, length : String | Nil)
      @length =
        if length.nil?
          length
        else
          Length.parse(length)
        end
    end

    def to_s(io : IO)
      io << "File:   " << @file << "\n"
      io << "Title:  " << @title << "\n" unless @title.nil?
      io << "Length: " << @length << "\n" unless @length.nil?
    end
  end
end
