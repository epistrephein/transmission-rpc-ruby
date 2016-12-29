module Transmission
  # Returns all torrents.
  def self.all(connector = nil)
    t = Transmission::Model::Torrent.all connector: connector
    case t.ids.size
    when 0 then Array([])
    when 1 then Array(t)
    else Array(t.torrents)
    end
  end

  # Returns all finished torrents.
  def self.finished
    all.select { |t| t.attributes['isFinished'] }
  end

  # Returns all completed torrents.
  def self.completed
    all.select { |t| t.attributes['percentDone'] >= 1 }
  end

  # Returns all incomplete torrents.
  def self.incomplete
    all.select { |t| t.attributes['percentDone'] < 1 }
  end

  # Returns all paused torrents.
  def self.paused
    all.select { |t| t.attributes['status'] == 0 }
  end

  # Returns all queued torrents.
  def self.queued
    all.select { |t| t.attributes['status'] == 3 }
  end

  # Returns all downloading torrents.
  def self.downloading
    all.select { |t| t.attributes['status'] == 4 }
  end

  # Returns all seeding torrents.
  def self.seeding
    all.select { |t| t.attributes['status'] == 6 }
  end

  # Returns all torrents with errors.
  def self.errors
    all.select { |t| t.attributes['error'] != 0 }
  end

  # Returns the hash of every torrents.
  def self.hashes
    all.map { |t| t.attributes['hashString'] }
  end

  # Returns all torrents whose name matches +name+.
  def self.find_by_name(name)
    re = name.split(' ').join('.*')
    all.select { |t| t.attributes['name'] =~ /#{re}/i }
  end

  # Returns all torrents whose hash matches +hash+.
  def self.find_by_hash(hash)
    all.select { |t| t.attributes['hashString'].casecmp(hash).zero? }
  end

  # Returns all torrents whose id matches +id+.
  def self.find_by_id(id)
    all.select { |t| t.attributes['id'] == id }
  end

  # Returns all torrents whose trackers match +tracker+.
  # FIXME: regex matching is not very precise.
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
end
