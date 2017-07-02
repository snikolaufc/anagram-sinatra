# frozen_string_literal: true

# Builds hash with where keys created from input list *words*
# values are arrays where elements are all anagrams for a given word found in *dictionary*
# if no anagrams are found for a given word value list will be empty
# Examples:
#   Given:
#     dictionary: ['cat', 'act', 'ogd']
#     words: ['tac', 'fox', 'dog']
#   Method will return the following hash:
#     { 'tac' => ['cat', 'act'], 'fox' => [], 'dog' => ['ogd'] }
# Usage:
#   AnagramFinder.new(['cat', 'act', 'ogd']).call(['tac', 'fox', 'dog'])
#   #=> { 'tac' => ['cat', 'act'], 'fox' => [], 'dog' => ['ogd'] }
class AnagramFinder
  def self.call(words)
    new(words).call
  end

  def initialize(dictionary)
    @dictionary = hash_raw_dictionary(Array(dictionary))
  end

  def hash_raw_dictionary(raw_dictionary)
    raw_dictionary.each_with_object(Hash.new([])) do |entry, result|
      result[sort_word(entry)] += [entry]
    end
  end

  def call(words)
    @searchable = Array(words).uniq
    return {} if @searchable.empty?

    find_anagrams
  end

  private

  attr_reader :searchable, :dictionary, :word_hash

  def find_anagrams
    searchable.each_with_object(Hash.new([])) do |word, result|
      result[word] += dictionary[sort_word(word)]
    end
  end

  def sort_word(word)
    word.split('').sort.join
  end
end
