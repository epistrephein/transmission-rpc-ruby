module Transmission
  module Model
    class Torrent
      # Removes torrent.
      def remove!
        connector.remove_torrent @ids
        @deleted = true
      end

      # Removes torrent and trashes data files.
      def remove_data!
        connector.remove_torrent @ids, true
        @deleted = true
      end
    end
  end
end
