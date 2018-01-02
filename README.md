# pls

A small library to parse [PLS playlists](https://en.wikipedia.org/wiki/PLS_(file_format))

A PLS playlist is simply an INI file with a predefined set of keys.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  pls:
    github: tijn/pls.cr
```

## Usage

```crystal
require "pls"

playlist = PLS::Playlist.parse(File.read("name_of_file.pls"))
playlist.entries.each do |entry|
  puts entry.file
end
```

## Development

You can clone it and improve it I guess ...

## Contributing

1. Fork it ( https://github.com/tijn/pls/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tijn](https://github.com/tijn) Tijn Schuurmans - creator, maintainer
