module Transmission
  module Model
    class Torrent
      # Returns true if torrent is paused.
      def paused?
        attributes['status'] == 0
      end

      # Returns true if torrent is queued.
      def queued?
        attributes['status'] == 3
      end

      # Returns true if torrent is downloading.
      def downloading?
        attributes['status'] == 4
      end

      # Returns true if torrent is seeding.
      def seeding?
        attributes['status'] == 6
      end

      # Returns true if torrent is isolated.
      def isolated?
        attributes['status'] == 7
      end

      # Returns true if torrent is finished.
      def finished?
        attributes['isFinished']
      end

      # Returns true if torrent is completed.
      def completed?
        attributes['percentDone'] >= 1
      end

      # Returns true if torrent is not completed.
      def incomplete?
        attributes['percentDone'] < 1
      end

      # Returns true if torrent has errors.
      def error?
        attributes['error'] != 0
      end
    end
  end
end
