class Blueprint < ActiveRecord::Base
  # Relations
  has_many :blueprint_invention_materials, foreign_key: :id
  has_many :blueprint_invention_products, foreign_key: :id
  has_many :blueprint_invention_skills, foreign_key: :id
  has_many :blueprint_manufacturing_materials, foreign_key: :id
  has_many :blueprint_manufacturing_products, foreign_key: :id
  has_many :blueprint_manufacturing_skills, foreign_key: :id

  def set_as_relation_loaded!
    %i[
      blueprint_invention_materials
      blueprint_invention_products
      blueprint_invention_skills
      blueprint_manufacturing_materials
      blueprint_manufacturing_products
      blueprint_manufacturing_skills
    ].each { |relation| association(relation).loaded! }
  end
end
