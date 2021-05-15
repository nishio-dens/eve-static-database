require "active_model"
require "active_record"
require "./importer/importer"
require "./models/models"

Importer::BlueprintImporter.new.execute
