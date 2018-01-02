require "ini"

module PLS
  # https://en.wikipedia.org/wiki/PLS_(file_format)
  class Playlist
    FILE_KEY   = /\AFile\d+\z/
    TITLE_KEY  = /\ATitle\d+\z/
    LENGTH_KEY = /\ALength\d+\z/

    # Creates a new Playlist object.
    def initialize(@data = {} of String => String)
    end

    # Parses the given string (with the contents of a PLS playlist) and returns a Playlist object.
    def self.parse(string : String)
      pls = INI.parse(string)
      new(pls["playlist"])
    end

    # Output all entries to *`io`*.
    def to_s(io : IO)
      entries.each do |entry|
        io << entry << "\n"
      end
    end

    # Returns all file fields.
    def files
      select_by_key_format(FILE_KEY)
    end

    # Returns track titles. (Track titles are optional in a PLS).
    def titles
      select_by_key_format(TITLE_KEY)
    end

    # Returns all length values. A length is defined in seconds. A value of -1 indicates indefinite length (streaming). (optional)
    def lengths
      select_by_key_format(LENGTH_KEY)
    end

    # Returns all key-value pairs in a particular format since keys in a PLS look like File1, File2, File3, etc.
    private def select_by_key_format(format)
      @data.select { |key, _value| key =~ format }
    end

    # Return the number of entries as stored in the PLS.
    def number_of_entries
      @data["NumberOfEntries"].to_i
    rescue KeyError
      files.size
    end

    # Returns true if the `Playlist` has no entries.
    def empty?
      number_of_entries == 0
    end

    # Retturns the `Playlist` version. Currently only a value of 2 is valid. It will return "1" if the field is missing.
    def version_field
      @data["Version"]
    rescue KeyError
      # if the Version field is missing, it means it's pre-version 2 ==> 1
      "1"
    end

    # Returns an `Array` of `PLS::Entry` objects.
    def entries
      number_of_entries.times.map do |i|
        number = i + 1
        Entry.new(
          @data.fetch("File#{number}", "?"),
          @data.fetch("Title#{number}", nil),
          @data.fetch("Length#{number}", nil))
      end.to_a
    end
  end
end
