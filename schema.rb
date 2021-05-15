create_table :blueprints, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true, comment: "TypeID"
  t.varchar :name, limit: 512, default: ""
  t.int :max_production_limit
  t.int :copying_time, null: true
  t.int :research_material_time, null: true
  t.int :research_time, null: true
  t.int :invention_time, null: true
  t.int :manufacturing_time, null: true
end

create_table :blueprint_invention_materials, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true
  t.int :type_id
  t.int :quantity
end

create_table :blueprint_invention_products, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true
  t.int :type_id
  t.int :quantity
  t.decimal :probability, null: true, precision: 12, scale: 3
end

create_table :blueprint_invention_skills, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true
  t.int :type_id
  t.int :level
end

create_table :blueprint_manufacturing_materials, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true
  t.int :type_id
  t.int :quantity
end

create_table :blueprint_manufacturing_products, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true
  t.int :type_id
  t.int :quantity
end

create_table :blueprint_manufacturing_skills, default_charset: :utf8mb4, collate: :utf8mb4_unicode_ci, row_format: :dynamic do |t|
  t.bigint :id, primary_key: true
  t.int :type_id
  t.int :level
end
