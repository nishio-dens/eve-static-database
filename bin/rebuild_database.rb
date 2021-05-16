# Rebuild database
# bundle exec ruby bin/rebuild_database.rb

require "active_model"
require "active_record"
require "yaml"

ROOT_PATH = File.join(File.dirname(__FILE__), "../")
database_settings = YAML.load_file(File.join(ROOT_PATH, "database.yml"))
db_config = {
  adapter: "mysql2",
  username: database_settings["username"],
  password: database_settings["password"] || "",
  database: database_settings["database"],
  host: database_settings["host"] || "",
  port: database_settings["port"] || 3306
}
ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.connection.drop_database db_config[:database] rescue nil
ActiveRecord::Base.connection.create_database db_config[:database]
ActiveRecord::Base.connection.close

exec("bundle exec convergence apply -c ./database.yml schema.rb")
