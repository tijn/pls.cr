require "ini"

module Pls
  # https://en.wikipedia.org/wiki/PLS_(file_format)
  class Playlist
    FILE_KEY   = /\AFile\d+\z/
    TITLE_KEY  = /\ATitle\d+\z/
    LENGTH_KEY = /\ALength\d+\z/

    def initialize(@data : Hash(String, String))
    end

    def self.parse(string : String)
      pls = INI.parse(string)
      new(pls["playlist"])
    end

    def to_s(io : IO)
      entries.each do |entry|
        io << entry << "\n"
      end
    end

    # All file fields
    def files
      select_by_key_format(FILE_KEY)
    end

    # track titles. (optional)
    def titles
      select_by_key_format(TITLE_KEY)
    end

    # Length in seconds of track. Value of -1 indicates indefinite (streaming). (optional)
    def lengths
      select_by_key_format(LENGTH_KEY)
    end

    def select_by_key_format(format)
      @data.select { |key, _value| key =~ format }
    end

    def number_of_entries
      @data["NumberOfEntries"].to_i
    rescue KeyError
      files.size
    end

    # Playlist version. Currently only a value of 2 is valid. It will return "1" if the field is missing
    def version_field
      @data["Version"]
    rescue KeyError
      # if the Version field is missing, it means it's pre-version 2 ==> 1
      "1"
    end

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
