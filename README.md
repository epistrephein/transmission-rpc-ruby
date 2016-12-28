# Transmission RPC Ruby Extended

[![Gem Version](https://badge.fury.io/rb/transmission-rpc-ruby-ext.svg)](https://badge.fury.io/rb/transmission-rpc-ruby-ext) [![Build Status](https://travis-ci.org/epistrephein/transmission-rpc-ruby-ext.svg?branch=master)](https://travis-ci.org/epistrephein/transmission-rpc-ruby-ext) [![Code Climate](https://codeclimate.com/github/epistrephein/transmission-rpc-ruby-ext/badges/gpa.svg)](https://codeclimate.com/github/epistrephein/transmission-rpc-ruby-ext) [![Coverage Status](https://coveralls.io/repos/github/epistrephein/transmission-rpc-ruby-ext/badge.svg?branch=master)](https://coveralls.io/github/epistrephein/transmission-rpc-ruby-ext?branch=master) [![Dependency Status](https://gemnasium.com/badges/github.com/epistrephein/transmission-rpc-ruby-ext.svg)](https://gemnasium.com/github.com/epistrephein/transmission-rpc-ruby-ext) [![Inline docs](http://inch-ci.org/github/epistrephein/transmission-rpc-ruby-ext.svg?branch=master)](http://inch-ci.org/github/epistrephein/transmission-rpc-ruby-ext)

This is a fork of [transmission-rails/transmission-rpc-ruby](https://github.com/transmission-rails/transmission-rpc-ruby) with some shortcut methods added and revised codebase.

## Installation

```
gem install transmission-rpc-ruby-ext
```

Then require it

```ruby
require 'transmission'
```

## Additions

Get an array of all torrents

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
Transmission.error
```

All hashes of all torrents

```ruby
Transmission.hashes
```

Find torrents by name, hash, id or tracker

```ruby
Transmission.find_by_name('Ubuntu')
Transmission.find_by_hash('fe086f9b15e4956a671ab9b9c5da526e3d3b270c')
Transmission.find_by_id(5)
Transmission.find_by_tracker('open.demonii.com')
```

### Single torrent methods

```ruby
t = Transmission.all.first
```

Basic attributes

```ruby
t.name
# => "ubuntu-16.04-desktop-amd64.iso"
t.path
# => "/Users/epistrephein/Downloads/ubuntu-16.04-desktop-amd64.iso"
t.id
# => 13
t.hash
# => "4344503b7e797ebf31582327a5baae35b11bda01"
```

Status

```ruby
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

Size

```ruby
t.length
# => 1485881344
t.valid
# => 18232
t.percent_downloaded
# => 1.2
t.percent_uploaded
# => 0.1
t.percent_ratio
# => 0.1
t.ratio
# => -1.0
```

Speed

```ruby
t.speed_download
# => 12
t.speed_upload
# => 9
```

Ratio & ETA

```ruby
t.ratio
# => -1.0
t.eta
```

Files and folders

```ruby
t.file?
t.folder?
t.files
t.content
t.biggest
t.smallest
```

Magnet link

```ruby
t.magnet
```

Trackers

```ruby
t.trackers
```

Actions

```ruby
t.reload!
t.remove!
t.remove_data!
```
