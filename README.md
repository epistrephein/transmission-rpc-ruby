# Transmission RPC Ruby

[![Build Status](https://travis-ci.org/transmission-rails/transmission-rpc-ruby.svg?branch=master)](https://travis-ci.org/transmission-rails/transmission-rpc-ruby) [![Code Climate](https://codeclimate.com/github/transmission-rails/transmission-rpc-ruby/badges/gpa.svg)](https://codeclimate.com/github/transmission-rails/transmission-rpc-ruby) [![Dependency Status](https://gemnasium.com/transmission-rails/transmission-rpc-ruby.svg)](https://gemnasium.com/transmission-rails/transmission-rpc-ruby) [![Coverage Status](https://coveralls.io/repos/transmission-rails/transmission-rpc-ruby/badge.svg?branch=master)](https://coveralls.io/r/transmission-rails/transmission-rpc-ruby?branch=master) [![Gem Version](https://badge.fury.io/rb/transmission-rpc-ruby.svg)](http://badge.fury.io/rb/transmission-rpc-ruby)

Transmission RPC Ruby is a Ruby library to communicate with Transmission RPC (bittorrent client).
This library is based on this [spec](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt) and currently supports RPC versions >= 14

## Installation

    gem install transmission-rpc-ruby

Then require it

    require 'transmission'

## Getting started

To get started with this gem you need to decide if you are using this library to connect to one or multiple transmission daemons.
__Both is possible__

### Single connection

Just set up a single configuration with will be used throughout any library calls

    Transmission::Config.set host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}

    torrents = Transmission::Model::Torrent.all

### Multiple connections

Introducing the `Transmission::RPC` class, which represent all the raw rpc connection requests.

    rpc = Transmission::RPC.new host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}

    torrents = Transmission::Model::Torrent.all connector: rpc

This Object can be passed to any of the `Transmission::Model` classes. Examples are shown below.

### Configuration options

Both `Transmission::Config` and `Transmission::RPC` take the same arguments, these are the default settings:

    {
      host: 'localhost',
      port: 9091
      path: '/transmission/rpc',
      ssl: false,
      credentials: {username: 'transmission', password: '********'},
      session_id: ''
    }

### Torrents

To work with torrents you need use the `Transmission::Model::Torrent` class

#### Get all torrents

    torrents = Transmission::Model::Torrent.all

If only a few fields are required

    torrents = Transmission::Model::Torrent.all fields: ['id']

#### Find a torrent

    id = 1
    torrent = Transmission::Model::Torrent.find id

If only a few fields are required

    torrent = Transmission::Model::Torrent.find id, fields: ['id']

#### Add a torrent

    filename = 'http://example.com/torrent.torrent'
    torrent = Transmission::Model::Torrent.add arguments: {filename: filename}

__NOTE:__ you can also specify a magnet link instead

You can also ask for certain fields too

    filename = 'http://example.com/torrent.torrent'
    torrent = Transmission::Model::Torrent.add arguments: {filename: filename}, fields: ['id']

Or use an RPC connector instance

    rpc = Transmission::RPC.new host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}

    filename = 'http://example.com/torrent.torrent'
    torrent = Transmission::Model::Torrent.add arguments: {filename: filename}, fields: ['id'], connector: rpc

#### Torrent instance methods

    id = 1
    torrent = Transmission::Model::Torrent.find(id)

    torrent.start!
    torrent.start_now!
    torrent.stop!
    torrent.verify!
    torrent.re_announce!

    torrent.move_up!
    torrent.move_down!
    torrent.move_top!
    torrent.move_bottom!

    torrent.finished?
    # => true

    torrent.to_json
    # => {"id"=>132, "name"=>"Torrent Name", ....}

You can access the torrent accessors & mutators via instance methods too

    # uploadLimited
    torrent.upload_limited
    torrent.upload_limited = true

    torrent.save!

The `save!` method will update the torrent on your remote transmission daemon.

To find all the torrent [accessors](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt#L127) & [mutators](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt#L90) visit [spec](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt)

#### Start & Stop all torrents

You can also start and stop all torrents

    Transmission::Model::Torrent.start_all!

    Transmission::Model::Torrent.stop_all!

#### Dealing with multiple torrents

If you want to change multiple torrents at once:

    ids = [1, 2, 3]
    torrents = Transmission::Model::Torrent.find ids

This will return a `Transmission::Model::Torrent` instance which takes the same methods as described before.

    torrents.start!
    torrents.stop!
    # ...

    torrents.to_json
    # => [{"id"=>132, "name"=>"Torrent Name", ....}, {...}]

    # uploadLimited
    torrents.upload_limited = false
    torrents.save!

This will change `uploadLimited` for all torrents with ids 1, 2 & 3.

__NOTE:__ If using `Transmission::Model::Torrent` you will only be able to modify their mutators.

To find out if a torrent instance contains multiple torrents

    torrents.is_multi?
    # => true

### Session

To find out more about the current session use the `Transmission::Model::Session` class.

#### Get session

    session = Transmission::Model::Session.get

If only a few fields are required

    session = Transmission::Model::Session.get fields: ['version']

If used with a connector

    options = {}
    rpc = Transmission::RPC.new options

    session = Transmission::Model::Session.get connector: rpc

#### Change session

Like the `Transmission::Model::Torrent` class, you change some session properties

    session = Transmission::Model::Session.get

    # alt-speed-enabled
    session.alt_speed_enabled
    session.alt_speed_enabled = true

    session.save!

To find all the session [accessors](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt#L444) & [mutators](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt#L514) visit [spec](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt)

### Session Stats

You can also retrieve some session stats by using the `Transmission::Model::SessionStats` class

    session_stats = Transmission::Model::SessionStats.get

    # activeTorrentCount
    session_stats.active_torrent_count

For session stats there are no mutators. To find out more about the [accessors](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt#L531) visit the [spec](https://trac.transmissionbt.com/browser/trunk/extras/rpc-spec.txt)

### RPC Connector

If it is not desired to use any of the `Transmission::Model` classes you can use the RPC connector

#### Examples

    rpc = Transmission::RPC.new host: 'some.host', port: 9091, ssl: false, credentials: {username: 'transmission', password: '********'}

    session_body = rpc.get_session

    ids = [1, 2, 3]

    torrent_bodies = rpc.get_torrent ids
    rpc.start_torrent ids

For more methods check out `lib/transmission/rpc.rb`

## Changelog

### v0.3.1 (2015-04-03)

Bugfixes:

- `uninitialized constant Transmission::Model::SessionStats` error fix

### v0.3.0 (2015-04-02)

Features:

- ability to handle multiple torrents in one instance
- `start_all!` & `stop_all!` static class methods for torrents
- `reload!`, `to_json`, `is_multi?`, `is_finished` instance method for torrents
- `to_json` instance method for session & session stats

### v0.2.1 (2015-04-01)

Bugfixes:

- when adding torrents the returned torrent instance will use same options for finding added torrent

### v0.2.0 (2015-03-31)

Features:

- all basic torrent actions (start, stop, move up queue, etc)
- session model
- session stats model
- adding torrents

### v0.1.0 (2015-03-12)

- Initial project import

## Roadmap

- Add support for all versions of RPC
- More documentation
- Add 'torrent-rename-path' & 'torrent-set-location' & 'port-test' & 'free-space' & 'session-close' RPC methods

## Contribute

Please help make this gem awesome! If you have any suggestions or feedback either create an issue or PR.
Just make sure you run the tests before.