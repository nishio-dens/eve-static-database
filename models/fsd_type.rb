class FsdType < ActiveRecord::Base
  # Constants
  BLUEPRINT_RELATIONS = %i[
  ].freeze

  # Relations

  # Methods
  def set_as_relation_loaded!
    BLUEPRINT_RELATIONS.each { |relation| association(relation).loaded! }
  end
end
