module Transmission
  class Arguments
    class LocationSet < Transmission::Arguments
      ATTRIBUTES = [
        { field: 'ids' },
        { field: 'location' },
        { field: 'move' }
      ].freeze
    end
  end
end
