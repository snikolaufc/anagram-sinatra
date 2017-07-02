# frozen_string_literal: true

require 'rack/test'
require 'json'

# Load fixture dictionary to reduce test timing
ENV['DICTIONARY_PATH'] = File.expand_path('../../fixtures/dictionary.txt', __FILE__)

require_relative '../../lib/app'
set :environment, :test

RSpec.describe 'Web server' do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'GET /' do
    it 'returns error json body' do
      get('/')
      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)).to match('error' => /.*/)
    end
  end

  describe 'GET /:words' do
    let(:searchable_words) { %w[dog cat frog] }

    it 'returns expected hash with available anagrams' do
      get("/#{searchable_words.join(',')}")
      expect(last_response.body).to eq({ dog: %w[god ogd], cat: ['tac'], frog: [] }.to_json)
    end
  end
end
