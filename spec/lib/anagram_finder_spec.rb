# frozen_string_literal: true

require_relative '../../lib/anagram_finder'
RSpec.describe AnagramFinder do
  describe '#call' do
    let(:dictionary) { [] }
    subject { described_class.new(dictionary).call(searchable_words) }

    context 'when word array is empty' do
      let(:searchable_words) { [] }
      it 'returns empty map' do
        expect(subject).to eq({})
      end
    end

    context 'when word_array is nil' do
      let(:searchable_words) { nil }
      it 'returns empty map' do
        expect(subject).to eq({})
      end
    end

    context 'when word array is not empty' do
      let(:searchable_words) { %w[tac fox dog] }
      context 'when there is no matching anagrams' do
        it 'returns a result with empty anagram values' do
          expect(subject).to match('tac' => [], 'fox' => [], 'dog' => [])
        end
      end

      context 'when there are anagram matches' do
        let(:dictionary) { %w[cat act ogd] }
        it 'returns a result with matched anagrams' do
          expect(subject).to match('tac' => %w[cat act], 'fox' => [], 'dog' => ['ogd'])
        end
      end
    end
  end
end
