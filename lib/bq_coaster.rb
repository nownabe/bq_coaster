# frozen_string_literal: true

require "bq_coaster/version"

module BqCoaster
  EDGE_PROPERTIES = %i(
    _type
    _mode
    _original_type
    _convert
  ).freeze

  def self.edge_properties
    EDGE_PROPERTIES
  end
end
