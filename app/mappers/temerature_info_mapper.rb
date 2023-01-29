# frozen_string_literal: true

class TemeratureInfoMapper < Dry::Transformer::Pipe
  import Dry::Transformer::HashTransformations

  define! do
    symbolize_keys
    accept_keys %i[location time value]
    map_value :time, ->(time) { Time.at time }
  end

  def call(input, **extra)
    super(input).merge extra
  end
end
