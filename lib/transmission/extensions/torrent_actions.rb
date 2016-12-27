module Transmission
  module Model
    class Torrent
      def remove!
        connector.remove_torrent @ids
        @deleted = true
      end

      def remove_data!
        connector.remove_torrent @ids, true
        @deleted = true
      end
    end
  end
end
