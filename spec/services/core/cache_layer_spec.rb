# frozen_string_literal: true

RSpec.describe Core::CacheLayer do
  before do
    @rails_cache = Rails.cache
    Rails.cache = ActiveSupport::Cache::MemoryStore.new
  end

  after do
    Rails.cache = @rails_cache
  end

  context 'when pluged on to successor, that able to process a message' do
    let(:successor_stub) { double hello: :some_result }

    before do
      Rails.cache.clear
    end

    it 'handle message to successor' do
      expect(described_class.new(10).plug_on(successor_stub).handle(:hello)).to eq(:some_result)
      expect(successor_stub).to have_received(:hello).once
    end

    it 'call successor once' do
      target = described_class.new(10).plug_on(successor_stub)
      3.times { expect(target.handle(:hello)).to eq(:some_result) }
      expect(successor_stub).to have_received(:hello).once
    end

    it 'call successor every time when gets new params' do
      target = described_class.new(10).plug_on(successor_stub)
      3.times { target.handle :hello, :people }
      3.times { target.handle :hello, :world }
      expect(successor_stub).to have_received(:hello).with(:world).once
      expect(successor_stub).to have_received(:hello).with(:people).once
    end
  end

  context 'when pluged on to successor, that unable to process a message' do
    it 'returns NotImplementedError' do
      expect { described_class.new(10).plug_on(Object.new).handle :hello }.to raise_error(Core::NotImplementedError)
    end
  end
end
