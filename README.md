# pls

A small library to parse [PLS playlists](https://en.wikipedia.org/wiki/PLS_(file_format))

If you understand the (extremely simple) PLS file format, I expect you understand the interface this library provides.

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

playlist = Pls::Playlist.parse(File.read("name_of_file.pls"))
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
