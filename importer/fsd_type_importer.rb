module Importer
  class FsdTypeImporter
    PATH = "/data/sde/fsd/typeIDs.yaml"
    BATCH_SIZE = 1000

    def execute
      rs = File.open(File.join(ROOT_PATH, PATH), "r") { |f| YAML.load(f) }
      rs.each_slice(BATCH_SIZE).each do |records|
        results = records.map do |record|
          FsdType.new.tap do |b|
            b.id = record[0]

            value = record[1]
          end
        end

        FsdType.insert_all(results.map(&:attributes))
        Blueprint::BLUEPRINT_RELATIONS.each do |relation_name|
          model = Blueprint::RELATION_CLASS_MAPPING[relation_name]
          values = results.flat_map(&relation_name).map(&:attributes)
          model.insert_all(values) if values.present?
        end
      end
    end
  end
end
