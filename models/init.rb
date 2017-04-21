# encoding: utf-8
require 'sequel'
database = Sequel.sqlite("db/database-development.db")

# load Sequel serializer to overwrite standard to_json method
Sequel::Model.plugin :json_serializer

require_relative 'user'
require_relative 'post'
require_relative 'comment'
require_relative 'subscription'
