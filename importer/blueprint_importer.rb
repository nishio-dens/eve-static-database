module Importer
  class BlueprintImporter
    PATH = "/data/sde/fsd/blueprints.yaml"
    BATCH_SIZE = 1000

    def execute
      rs = File.open(File.join(ROOT_PATH, PATH), "r") { |f| YAML.load(f) }
      rs.each_slice(BATCH_SIZE).each do |records|
        results = records.map do |record|
          Blueprint.new.tap do |b|
            b.id = record[0]

            value = record[1]
            b.max_production_limit = value.dig("maxProductionLimit")

            set_activities(b, value.dig("activities"))
            b.set_as_relation_loaded!
          end
        end

        Blueprint.insert_all(results.map(&:attributes))
        Blueprint::BLUEPRINT_RELATIONS.each do |relation_name|
          model = Blueprint::RELATION_CLASS_MAPPING[relation_name]
          values = results.flat_map(&relation_name).map(&:attributes)
          model.insert_all(values) if values.present?
        end
      end
    end

    private

    def set_activities(blueprint, value)
      blueprint.tap do |b|
        b.research_material_time = value.dig("research_material", "time")
        b.research_time = value.dig("research_time", "time")

        set_copying(b, value.dig("copying"))
        set_invention(b, value.dig("invention"))
        set_manufacturing(b, value.dig("manufacturing"))
        set_reaction(b, value.dig("reaction"))
      end
    end

    def set_copying(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        b.copying_time = value.dig("time")

        set_copying_materials(b, value.dig("materials"))
        set_copying_skills(b, value.dig("skills"))
      end
    end

    def set_copying_materials(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |m|
          b.blueprint_copying_materials.build(
            type_id: m["typeID"],
            quantity: m["quantity"]
          )
        end
      end
    end

    def set_copying_skills(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |s|
          b.blueprint_copying_skills.build(
            type_id: s["typeID"],
            level: s["level"]
          )
        end
      end
    end

    def set_invention(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        b.invention_time = value.dig("time")

        set_invention_materials(b, value.dig("materials"))
        set_invention_products(b, value.dig("products"))
        set_invention_skills(b, value.dig("skills"))
      end
    end

    def set_invention_materials(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |m|
          b.blueprint_invention_materials.build(
            type_id: m["typeID"],
            quantity: m["quantity"]
          )
        end
      end
    end

    def set_invention_products(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |p|
          b.blueprint_invention_products.build(
            type_id: p["typeID"],
            quantity: p["quantity"],
            probability: p["probability"]
          )
        end
      end
    end

    def set_invention_skills(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |s|
          b.blueprint_invention_skills.build(
            type_id: s["typeID"],
            level: s["level"]
          )
        end
      end
    end

    def set_manufacturing(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        b.manufacturing_time = value.dig("time")

        set_manufacturing_materials(b, value.dig("materials"))
        set_manufacturing_products(b, value.dig("products"))
        set_manufacturing_skills(b, value.dig("skills"))
      end
    end

    def set_manufacturing_materials(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |m|
          b.blueprint_manufacturing_materials.build(
            type_id: m["typeID"],
            quantity: m["quantity"]
          )
        end
      end
    end

    def set_manufacturing_products(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |p|
          b.blueprint_manufacturing_products.build(
            type_id: p["typeID"],
            quantity: p["quantity"]
          )
        end
      end
    end

    def set_manufacturing_skills(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |s|
          b.blueprint_manufacturing_skills.build(
            type_id: s["typeID"],
            level: s["level"]
          )
        end
      end
    end

    def set_reaction(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        b.reaction_time = value.dig("time")

        set_reaction_materials(b, value.dig("materials"))
        set_reaction_products(b, value.dig("products"))
        set_reaction_skills(b, value.dig("skills"))
      end
    end

    def set_reaction_materials(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |m|
          b.blueprint_reaction_materials.build(
            type_id: m["typeID"],
            quantity: m["quantity"]
          )
        end
      end
    end

    def set_reaction_products(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |p|
          b.blueprint_reaction_products.build(
            type_id: p["typeID"],
            quantity: p["quantity"]
          )
        end
      end
    end

    def set_reaction_skills(blueprint, value)
      return blueprint if value.blank?

      blueprint.tap do |b|
        Array(value).each do |s|
          b.blueprint_reaction_skills.build(
            type_id: s["typeID"],
            level: s["level"]
          )
        end
      end
    end
  end
end
