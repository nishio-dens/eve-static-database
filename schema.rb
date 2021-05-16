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
  t.int :type_id
  t.int :quantity

  t.index [:id, :activity_type], unique: true
end

create_table :blueprint_products, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id
  t.varchar :activity_type, limit: 20
  t.int :type_id
  t.int :quantity
  t.decimal :probability, null: true, precision: 12, scale: 3

  t.index [:id, :activity_type], unique: true
end

create_table :blueprint_skills, default_charset: :utf8mb4, collate: :utf8mb4_general_ci, row_format: :dynamic do |t|
  t.bigint :id
  t.varchar :activity_type, limit: 20
  t.int :type_id
  t.int :level

  t.index [:id, :activity_type], unique: true
end
