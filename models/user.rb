#encoding: utf-8
require 'digest'

class User < Sequel::Model
  def auth pwd
    Digest::SHA256.hexdigest(pwd+self.salt) == self.pwdhash
  end
end