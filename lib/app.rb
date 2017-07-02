# frozen_string_literal: true

require 'sinatra'
require 'sinatra/contrib'
require_relative 'anagram_finder'

# Main web service class
class App < Sinatra::Base
  DICTIONARY_PATH = ENV.fetch('DICTIONARY_PATH') { File.expand_path('../data/dictionary.txt', __dir__) }
  AnagramWithDictionary = ::AnagramFinder.new(File.foreach(DICTIONARY_PATH).map(&:chomp))

  set :protection, except: [:json_csrf]

  get '/' do
    json error: 'No words have been passed'
  end

  get '/:words' do
    json AnagramWithDictionary.call(words)
  end

  private

  def words
    params[:words].split(',')
  end
end
