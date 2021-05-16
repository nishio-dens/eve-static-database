require "active_model"
require "active_record"
require "yaml"
require "logger"

if ENV["ENV"] == "development"
  require "pry"
end

module Importer
  ROOT_PATH = File.join(File.dirname(__FILE__))
end

Dir[File.dirname(__FILE__) + "/models/*.rb"].each { |file| require file }
Dir[File.dirname(__FILE__) + "/importer/*.rb"].each { |file| require file }

database_settings = YAML.load_file(File.join(Importer::ROOT_PATH, "database.yml"))
db_config = {
  adapter: "mysql2",
  username: database_settings["username"],
  password: database_settings["password"] || "",
  database: database_settings["database"],
  host: database_settings["host"] || "",
  port: database_settings["port"] || 3306
}
ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.logger = Logger.new(STDOUT)
