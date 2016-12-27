module Transmission
  module Model
    class Torrent
      # torrent attributes methods
      def name
        attributes['name']
      end

      def path
        dir = File.expand_path(attributes['downloadDir'])
        File.join(dir, name)
      end

      def id
        attributes['id']
      end

      def hash
        attributes['hashString']
      end

      def length
        attributes['totalSize']
      end

      def valid
        attributes['haveValid']
      end

      def percent_downloaded
        (attributes['haveValid'] * 1.0 / attributes['totalSize']).round(2)
      end

      def percent_uploaded
        (attributes['uploadedEver'] * 1.0 / attributes['totalSize']).round(2)
      end

      def percent_ratio
        session = Transmission::Model::Session.get
        return unless session.seed_ratio_limited
        (attributes['uploadRatio'] * 1.0 / session.seed_ratio_limit).round(2)
      end

      def speed_download
        attributes['rateDownload']
      end

      def speed_upload
        attributes['rateUpload']
      end

      def ratio
        (attributes['uploadRatio'] * 1.0).round(2)
      end

      def eta
        pretty_time(attributes['eta']) if attributes['eta'] > 0
      end

      def file?
        name = attributes['name']
        files = attributes['files']
        files.size == 1 && files.first['name'] == name
      end

      def folder?
        !file?
      end

      def files
        dir = File.absolute_path(attributes['downloadDir'])
        attributes['files'].map { |f| File.join(dir, f['name']) }
      end

      def content
        files.map { |f| File.basename(f) }
      end

      def biggest
        b = attributes['files'].max_by { |f| f['length'] }
        [File.basename(b['name']), b['length']]
      end

      def smallest
        b = attributes['files'].min_by { |f| f['length'] }
        [File.basename(b['name']), b['length']]
      end

      def magnet
        attributes['magnetLink']
      end

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
