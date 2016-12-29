module Transmission
  module Model
    class Torrent
      # Returns torrent name.
      def name
        attributes['name']
      end

      # Returns torrent full download path.
      def path
        dir = File.expand_path(attributes['downloadDir'])
        File.join(dir, name)
      end

      # Returns torrent id.
      def id
        attributes['id']
      end

      # Returns torrent hash.
      def hash
        attributes['hashString']
      end

      # Returns torrent size.
      def length
        attributes['totalSize']
      end

      # Returns torrent downloaded files size.
      def valid
        attributes['haveValid']
      end

      # Returns torrent downloaded files percent.
      def percent_downloaded
        (attributes['haveValid'] * 1.0 / attributes['totalSize']).round(2)
      end

      # Returns torrent uploaded files percent.
      def percent_uploaded
        (attributes['uploadedEver'] * 1.0 / attributes['totalSize']).round(2)
      end

      # Returns torrent ratio percent if session ratio is set.
      def percent_ratio
        session = Transmission::Model::Session.get
        return unless session.seed_ratio_limited
        (attributes['uploadRatio'] * 1.0 / session.seed_ratio_limit).round(2)
      end

      # Returns torrent download speed.
      def speed_download
        attributes['rateDownload']
      end

      # Returns torrent upload speed.
      def speed_upload
        attributes['rateUpload']
      end

      # Returns torrent ratio.
      def ratio
        (attributes['uploadRatio'] * 1.0).round(2)
      end

      # Returns torrent eta.
      def eta
        pretty_time(attributes['eta']) if attributes['eta'] > 0
      end

      # Returns true if torrent is a single file.
      def file?
        name = attributes['name']
        files = attributes['files']
        files.size == 1 && files.first['name'] == name
      end

      # Returns true if torrent is a folder.
      def folder?
        !file?
      end

      # Returns all torrent files full path.
      def files
        dir = File.absolute_path(attributes['downloadDir'])
        attributes['files'].map { |f| File.join(dir, f['name']) }
      end

      # Returns torrent files names.
      def content
        files.map { |f| File.basename(f) }
      end

      # Returns torrent biggest file and size.
      def biggest
        b = attributes['files'].max_by { |f| f['length'] }
        [File.basename(b['name']), b['length']]
      end

      # Returns torrent smallest file and size.
      def smallest
        b = attributes['files'].min_by { |f| f['length'] }
        [File.basename(b['name']), b['length']]
      end

      # Returns torrent error string.
      def error
        attributes['errorString'] if error?
      end

      # Returns torrent magnet link.
      def magnet
        attributes['magnetLink']
      end

      # Returns torrent trackers.
      def trackers
        url_regex = /([-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b)(?:[-a-zA-Z0-9@:%_\+.~#?&\/=]*)/i
        attributes['trackers'].map do |r|
          if (a = r['announce'].match(url_regex))
            a[1]
          end
        end.compact
      end
    end
  end
end
