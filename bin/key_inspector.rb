# bundle exec ruby bin/key_inspector.rb ./data/sde/fsd/typeIDs.yaml

require "yaml"
require "active_support"
require "pry"

def create_key_value_schema(key, value)
  if value.is_a?(Hash)
    r = value.map { |k, v| create_key_value_schema(k, v) }.reduce { |a, e| a.merge(e) }
    { key => r }
  elsif value.is_a?(Array)
    r = value.flat_map do |a|
      if a.is_a?(Hash)
        a.map { |k, v| create_key_value_schema(k, v) }
      else
        a
      end
    end
    { key => r }
  elsif value.nil?
    {}
  else
    { key => value }
  end
end

records = YAML.load_file(File.open(ARGV[0]))

schema = {}

records.each do |_, record|
  record.map do |key, value|
    s = create_key_value_schema(key, value)
    schema = schema.deep_merge(s)
  end
end

pp schema
