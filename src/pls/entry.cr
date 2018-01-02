module PLS
  # An entry in a `PLS::Playlist`
  class Entry
    # Returns the filename.
    getter file
    # Returns the title. (optional)
    getter title
    # Returns the length. (optional)
    getter length

    def initialize(@file : String, @title : String | Nil, length : String | Nil)
      @length =
        if length.nil?
          length
        else
          Length.parse(length)
        end
    end

    # Converts to a `String`.
    def to_s(io : IO)
      io << "File:   " << @file << "\n"
      io << "Title:  " << @title << "\n" unless @title.nil?
      io << "Length: " << @length << "\n" unless @length.nil?
    end
  end
end
