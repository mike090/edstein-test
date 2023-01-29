# frozen_string_literal: true

class AccuweatherApiMapper < Dry::Transformer::Pipe
  import Dry::Transformer::ArrayTransformations

  define! do
    map_array lambda { |t_info|
      {
        time: t_info['EpochTime'],
        value: t_info.dig('Temperature', 'Metric', 'Value')
      }
    }
  end
end
