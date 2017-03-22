require_relative 'spec_helper'
require 'rack/test'
require_relative '../main'

database = Sequel.sqlite('db/database-development.db')
RSpec.describe 'User' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'User will be created' do
    context 'new user created' do
      it 'will set the correct mail address in th database' do
        # post 'users", name: "Peter", email: "peter@pan.de'
        post '/users', '{ "name": "Peter", "email": "peter@pan.de" }', { CONTENT_TYPE: 'application/json' }

        row = database[:users][name: 'Peter']
        expect(row[:email]).to eq('peter@pan.de')
        expect(last_response.status).to eq 201
      end
    end
  end

end