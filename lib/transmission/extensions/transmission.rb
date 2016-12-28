module Transmission
  # list torrents methods
  def self.all(connector = nil)
    t = Transmission::Model::Torrent.all connector: connector
    case t.ids.size
    when 0 then Array([])
    when 1 then Array(t)
    else Array(t.torrents)
    end
  end

  def self.finished
    all.select { |t| t.attributes['isFinished'] }
  end

  def self.completed
    all.select { |t| t.attributes['percentDone'] >= 1 }
  end

  def self.incomplete
    all.select { |t| t.attributes['percentDone'] < 1 }
  end

  def self.paused
    all.select { |t| t.attributes['status'] == 0 }
  end

  def self.queued
    all.select { |t| t.attributes['status'] == 3 }
  end

  def self.downloading
    all.select { |t| t.attributes['status'] == 4 }
  end

  def self.seeding
    all.select { |t| t.attributes['status'] == 6 }
  end

  def self.error
    all.select { |t| t.attributes['error'] != 0 }
  end

  def self.hashes
    all.map { |t| t.attributes['hashString'] }
  end

  # find torrents methods
  def self.find_by_name(name)
    re = name.split(' ').join('.*')
    all.select { |t| t.attributes['name'] =~ /#{re}/i }
  end

  def self.find_by_hash(hash)
    all.select { |t| t.attributes['hashString'].casecmp(hash) == 0 }
  end

  def self.find_by_id(id)
    all.select { |t| t.attributes['id'] == id }
  end

  def self.find_by_tracker(tracker)
    url_regex = /([-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b)(?:[-a-zA-Z0-9@:%_\+.~#?&\/=]*)/i
    re = tracker.split(' ').join('.*')
    all.select do |t|
      trackers = t.attributes['trackers'].map do |r|
        if (a = r['announce'].match(url_regex))
          a[1]
        end
      end
      trackers.any? { |r| r =~ /#{re}/i }
    end
  end

  # add torrents methods
  def self.add(file, connector = nil)
    Transmission::Model::Torrent.add(
      connector: connector,
      arguments: { filename: file }
    )
  end
end
