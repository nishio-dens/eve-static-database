module Importer
  class BlueprintImporter
    PATH = "/data/sde/fsd/blueprints.yaml"
    BATCH_SIZE = 1000

    def execute
      rs = File.open(File.join(ROOT_PATH, PATH), "r") { |f| YAML.load(f) }
      rs.each_slice(BATCH_SIZE).each do |records|
        records.map do |record|
          b = BluePrint.new
          b.id = record[0]
          b.name = ""

          val = records[1]
          b.max_production_limit = val.dig("maxProductionLimit")
          b.copying_time = val.dig("activities", "copying", "time")
        end
      end

      require "pry"; binding.pry
    end
  end
end
