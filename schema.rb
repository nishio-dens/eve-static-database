create_table :blueprints, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true, comment: "TypeID"
  t.int :max_production_limit
  t.int :copying_time, null: true
  t.int :research_material_time, null: true
  t.int :research_time, null: true
  t.int :invention_time, null: true
  t.int :manufacturing_time, null: true
  t.int :reaction_time, null: true
end

create_table :blueprint_materials, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id
  t.varchar :activity_type, limit: 20
  t.bigint :type_id
  t.int :quantity

  t.index [:id, :activity_type], unique: true
end

create_table :blueprint_products, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id
  t.varchar :activity_type, limit: 20
  t.bigint :type_id
  t.int :quantity
  t.decimal :probability, null: true, precision: 12, scale: 3

  t.index [:id, :activity_type], unique: true
end

create_table :blueprint_skills, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id
  t.varchar :activity_type, limit: 20
  t.bigint :type_id
  t.int :level

  t.index [:id, :activity_type], unique: true
end

create_table :fsd_types, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true
  t.varchar :name, limit: 512, comment: "en name"

  t.bigint :graphic_id, null: true
  t.bigint :sound_id, null: true
  t.bigint :race_id, null: true
  t.bigint :group_id, null: true
  t.bigint :icon_id, null: true
  t.bigint :market_group_id, null: true
  t.bigint :meta_group_id, null: true
  t.boolean :published, null: true
  t.decimal :mass, precision: 64, scale: 3, null: true
  t.decimal :volume, precision: 64, scale: 3, null: true
  t.decimal :capacity, precision: 64, scale: 3, null: true
  t.decimal :radius, precision: 64, scale: 3, null: true
  t.decimal :best_price, precision: 64, scale: 3, null: true
  t.int :portion_size, null: true
  t.bigint :variation_parent_type_id, null: true
  t.bigint :faction_id, null: true
  t.varchar :sof_faction_name, null: true
  t.bigint :sof_material_set_id, null: true

  # TODO: support traits
end

create_table :fsd_type_translations, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id
  t.varchar :locale, limit: 2
  t.varchar :name, limit: 512
  t.longtext :description, null: true

  t.index [:id, :locale], unique: true
end

create_table :fsd_type_masteries, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id
  t.bigint :base_id
  t.int :order_number
  t.bigint :sub_id
end
