# frozen_string_literal: true

RSpec.describe AccuweatherAdapter do
  let(:t_info_keys) { %i[location time value unit] }

  describe '.current' do
    it 'returns an array with one hash with specific keys', :vcr do
      current_t_info = described_class.current 123
      expect(current_t_info.count).to eq 1
      expect(current_t_info[0].keys).to eq t_info_keys
    end
  end

  describe '.last_24h' do
    it 'returns an array of hashs with specific keys', :vcr do
      data = described_class.last_24h 123
      expect(data.count).to eq 24
      data.each { |t_info| expect(t_info.keys).to eq t_info_keys }
    end

    it 'raises exception unless responce code is 200', :vcr do
      expect { described_class.last_24h 0 }.to raise_error Faraday::Error
    end
  end
end
