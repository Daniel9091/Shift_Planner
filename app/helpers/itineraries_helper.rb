module ItinerariesHelper
    def day_options
      ['lunes', 'martes', 'miércoles', 'jueves', 'viernes']
    end

    def status_options
        ['Piloto', 'Pasajero']
    end

    def hour_options
        hours = []
        (0..23).each do |hour|
          ['00', '30'].each do |minute|
            hours << "#{hour.to_s.rjust(2, '0')}:#{minute}"
          end
        end
        hours
      end
  end