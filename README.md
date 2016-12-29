# Transmission RPC Ruby Extended

[![Gem Version](https://badge.fury.io/rb/transmission-rpc-ruby-ext.svg)](https://badge.fury.io/rb/transmission-rpc-ruby-ext) [![Build Status](https://travis-ci.org/epistrephein/transmission-rpc-ruby-ext.svg?branch=master)](https://travis-ci.org/epistrephein/transmission-rpc-ruby-ext) [![Code Climate](https://codeclimate.com/github/epistrephein/transmission-rpc-ruby-ext/badges/gpa.svg)](https://codeclimate.com/github/epistrephein/transmission-rpc-ruby-ext) [![Coverage Status](https://coveralls.io/repos/github/epistrephein/transmission-rpc-ruby-ext/badge.svg?branch=master)](https://coveralls.io/github/epistrephein/transmission-rpc-ruby-ext?branch=master) [![Dependency Status](https://gemnasium.com/badges/github.com/epistrephein/transmission-rpc-ruby-ext.svg)](https://gemnasium.com/github.com/epistrephein/transmission-rpc-ruby-ext) [![Inline docs](http://inch-ci.org/github/epistrephein/transmission-rpc-ruby-ext.svg?branch=master)](http://inch-ci.org/github/epistrephein/transmission-rpc-ruby-ext)

This is a fork of [transmission-rpc-ruby](https://github.com/transmission-rails/transmission-rpc-ruby) with some shortcut methods added and revised codebase.

Documentation for the original gem can be found in the [upstream repository](https://github.com/transmission-rails/transmission-rpc-ruby).

## Installation

```
gem install transmission-rpc-ruby-ext
```

Then require it

```ruby
require 'transmission'
```

If both `transmission-rpc-ruby` and `transmission-rpc-ruby-ext` gems are installed, specify the gem to require to avoid namespace conflict.

```ruby
gem 'transmission-rpc-ruby-ext'
require 'transmission'
```

## Extensions

### Transmission selectors

All torrents

```ruby
Transmission.all
```

All finished torrents

```ruby
Transmission.finished
```

All completed or incomplete torrents

```ruby
Transmission.completed
Transmission.incomplete
```

All torrents based on status

```ruby
Transmission.paused         # status 0
Transmission.queued         # status 3
Transmission.downloading    # status 4    
Transmission.seeding        # status 6
```

All torrents with error

```ruby
Transmission.errors
```

All hashes of all torrents

```ruby
Transmission.hashes
```

Find torrents by name, hash, id or tracker

```ruby
Transmission.find_by_name('ubuntu')
Transmission.find_by_hash('9f9165d9a281a9b8e782cd5176bbcc8256fd1871')
Transmission.find_by_id(1)
Transmission.find_by_tracker('torrent.ubuntu.com')
```

### Torrent status

```ruby
t = Transmission.all.first

t.paused?
# => false
t.queued?
# => false
t.downloading?
# => true
t.seeding?
# => false
t.finished?
# => false
t.completed?
# => false
t.incomplete?
# => false
t.error?
# => false
```

### Torrent attributes

Basic attributes

```ruby
t = Transmission.all.first

t.name
# => "ubuntu-16.04.1-desktop-amd64.iso"
t.path
# => "/Users/epistrephein/Downloads/ubuntu-16.04-desktop-amd64.iso"
t.id
# => 1
t.hash
# => "9f9165d9a281a9b8e782cd5176bbcc8256fd1871"
```

Size

```ruby
t.length
# => 1513308160
t.valid
# => 582696960
t.percent_downloaded
# => 0.39
t.percent_uploaded
# => 0.0
t.percent_ratio
# => nil
```

Speed

```ruby
t.speed_download
# => 14477000
t.speed_upload
# => 0
```

Ratio & ETA

```ruby
t.ratio
# => 0.0
t.eta
# => 85
```

Files and folders

```ruby
t.file?
# => true
t.folder?
# => false
t.files
# => ["/Users/epistrephein/Downloads/ubuntu-16.04-desktop-amd64.iso"]
t.content
# => ["ubuntu-16.04.1-desktop-amd64.iso"]
t.biggest
# => ["ubuntu-16.04.1-desktop-amd64.iso", 1513308160]
t.smallest
# => ["ubuntu-16.04.1-desktop-amd64.iso", 1513308160]
```

Peers

```ruby
t.peers
# => 11
t.peers_seeding
# => 9
t.peers_leeching
# => 0
```

Errors

```ruby
t.error
# => nil
```

Magnet link

```ruby
t.magnet
# => "magnet:?xt=urn:btih:9f9165d9a281a9b8e782cd5176bbcc8256fd1871&dn=ubuntu-16.04.1-desktop-amd64.iso&tr=http%3A%2F%2Ftorrent.ubuntu.com%3A6969%2Fannounce&tr=http%3A%2F%2Fipv6.torrent.ubuntu.com%3A6969%2Fannounce"
```

Trackers

```ruby
t.trackers
# => ["torrent.ubuntu.com", "ipv6.torrent.ubuntu.com"]
```

### Torrent prettified attributes

```ruby
t.pretty_length
# => "1.51GB"
t.pretty_valid
# => "582.7MB"
t.pretty_eta
# => "1 minutes, 25 seconds"
```

### Torrent actions

```ruby
t.reload!
t.remove!
t.remove_data!
```

## Contributing

Contributions are welcome and encouraged. Feel free to open an issue or submit a pull request.

## License
[MIT License](LICENSE)
