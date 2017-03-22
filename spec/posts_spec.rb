require_relative 'spec_helper'
require 'rack/test'
require_relative '../main'

RSpec.describe "Post" do
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  describe "GET home" do
    context "no todos" do
      it "returns no" do
        get "/"
        expect(last_response.body).to eq("")
        expect(last_response.status).to eq 200
      end
    end
  end

end