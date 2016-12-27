module Transmission
  module Model
    class Torrent
      # torrent status methods
      def paused?
        attributes['status'] == 0
      end

      def queued?
        attributes['status'] == 3
      end

      def downloading?
        attributes['status'] == 4
      end

      def seeding?
        attributes['status'] == 6
      end

      def isolated?
        attributes['status'] == 7
      end

      def finished?
        attributes['isFinished']
      end

      def completed?
        attributes['percentDone'] >= 1
      end

      def incomplete?
        attributes['percentDone'] < 1
      end

      def error?
        attributes['error'] != 0
      end
    end
  end
end
