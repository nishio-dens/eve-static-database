require_relative "blueprint_material"
require_relative "blueprint_product"
require_relative "blueprint_skill"

class Blueprint < ActiveRecord::Base
  # Constants
  BLUEPRINT_RELATIONS = %i[
    blueprint_copying_materials
    blueprint_copying_skills
    blueprint_invention_materials
    blueprint_invention_products
    blueprint_invention_skills
    blueprint_manufacturing_materials
    blueprint_manufacturing_products
    blueprint_manufacturing_skills
    blueprint_reaction_materials
    blueprint_reaction_products
    blueprint_reaction_skills
  ].freeze
  ACTIVITY_TYPES = %i[
    copying
    invention
    manufacturing
    reaction
  ].freeze
  RELATION_CLASS_MAPPING = {
    blueprint_copying_materials:       ::BlueprintMaterial,
    blueprint_copying_skills:          ::BlueprintSkill,
    blueprint_invention_materials:     ::BlueprintMaterial,
    blueprint_invention_products:      ::BlueprintProduct,
    blueprint_invention_skills:        ::BlueprintSkill,
    blueprint_manufacturing_materials: ::BlueprintMaterial,
    blueprint_manufacturing_products:  ::BlueprintProduct,
    blueprint_manufacturing_skills:    ::BlueprintSkill,
    blueprint_reaction_materials:      ::BlueprintMaterial,
    blueprint_reaction_products:       ::BlueprintProduct,
    blueprint_reaction_skills:         ::BlueprintSkill
  }.freeze

  # Relations
  has_many :blueprint_copying_materials,       -> { where(activity_type: "copying") },   foreign_key: :id, class_name: "BlueprintMaterial"
  has_many :blueprint_copying_skills,          -> { where(activity_type: "copying") },   foreign_key: :id, class_name: "BlueprintSkill"
  has_many :blueprint_invention_materials,     -> { where(activity_type: "invention") }, foreign_key: :id, class_name: "BlueprintMaterial"
  has_many :blueprint_invention_products,      -> { where(activity_type: "invention") }, foreign_key: :id, class_name: "BlueprintProduct"
  has_many :blueprint_invention_skills,        -> { where(activity_type: "invention") }, foreign_key: :id, class_name: "BlueprintSkill"
  has_many :blueprint_manufacturing_materials, -> { where(activity_type: "manufacturing") }, foreign_key: :id, class_name: "BlueprintMaterial"
  has_many :blueprint_manufacturing_products,  -> { where(activity_type: "manufacturing") }, foreign_key: :id, class_name: "BlueprintProduct"
  has_many :blueprint_manufacturing_skills,    -> { where(activity_type: "manufacturing") }, foreign_key: :id, class_name: "BlueprintSkill"
  has_many :blueprint_reaction_materials,      -> { where(activity_type: "reaction") }, foreign_key: :id, class_name: "BlueprintMaterial"
  has_many :blueprint_reaction_products,       -> { where(activity_type: "reaction") }, foreign_key: :id, class_name: "BlueprintProduct"
  has_many :blueprint_reaction_skills,         -> { where(activity_type: "reaction") }, foreign_key: :id, class_name: "BlueprintSkill"

  # Methods
  def set_as_relation_loaded!
    BLUEPRINT_RELATIONS.each { |relation| association(relation).loaded! }
  end
end
