module Pombo
  class Package
    module Format
      # Box or Package
      module Box
        CODE          = 1
        MAX_LENGTH    = 105
        MIN_LENGTH    = 16
        MAX_HEIGHT    = 105
        MIN_HEIGHT    = 2
        MAX_WIDTH     = 105
        MIN_WIDTH     = 11
        MAX_DIMENSION = 200
      end

      # Roll or Prism
      module Roll
        CODE          = 2
        MAX_LENGTH    = 105
        MIN_LENGTH    = 18
        MAX_DIAMETER  = 91
        MIN_DIAMETER  = 5
        MAX_DIMENSION = 200
      end

      # Envelope
      module Envelope
        CODE          = 3
        MAX_LENGTH    = 60
        MIN_LENGTH    = 16
        MAX_WIDTH     = 60
        MIN_WIDTH     = 11
      end
    end
  end
end
