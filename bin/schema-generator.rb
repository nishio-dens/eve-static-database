# Dump JSON Schema from YAML
#
# Run thes following command in the repo root directory:
#   bundle exec ruby bin/schema-generator.rb ./data/sde/fsd/blueprints.yaml

require "json-schema-generator"
require "yaml"

y = File.open(ARGV[0], "r") { |f| YAML.load_file(f) }
File.open("./tmp/tmp.json", "w") { |f| f.write(y.to_json) }

fname = "./tmp/tmp.json"
File.open("./tmp/tmp_schema.json", "w") do |f|
  d = JSON::SchemaGenerator.generate(fname, File.read(fname), { schema_version: "draft4" })
  f.write(d)
end
