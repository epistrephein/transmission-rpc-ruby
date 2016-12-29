module Transmission
  module Model
    class Torrent
      private

      # Converts filesize to proper units.
      def pretty_size(size)
        {
          'B'  => 1000**1,
          'KB' => 1000**2,
          'MB' => 1000**3,
          'GB' => 1000**4,
          'TB' => 1000**5
        }.each_pair do |e, s|
          return "#{(size.to_f / (s / 1000)).round(2)}#{e}" if size < s
        end
      end

      # Convert seconds in seconds/minutes/hours.
      def pretty_time(seconds)
        mm, ss = seconds.divmod(60)
        hh, mm = mm.divmod(60)
        dd, hh = hh.divmod(24)
        eta = {
          days: dd, hours: hh, minutes: mm, seconds: ss
        }.delete_if { |_k, v| v.zero? }
        eta.to_a.map { |e| e.reverse.join(' ') }.join(', ')
      end

      # Converts status code in status name.
      def status_name
        ['paused', 'check wait', 'check', 'download wait', 'download',
         'seed wait', 'seed', 'isolated'].at(status)
      end

      # Converts status code in status symbol.
      def status_symbol
        ['❚❚', '~', '⟳', '⥥', '⬇', '⥣', '⬆', '✘'].at(status)
      end
    end
  end
end
