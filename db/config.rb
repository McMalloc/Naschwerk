require 'sequel'

module Database
  DB_MODES = %w{development production test}
  def self.url(mode)
    raise "Unsupported runtime mode: #{mode.inspect}" unless DB_MODES.include? mode.to_s
    "sqlite://db/database-#{mode.to_s}.db"
  end
end
