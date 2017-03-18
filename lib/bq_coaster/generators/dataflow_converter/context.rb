# frozen_string_literal: true

require "bq_coaster"
require "bq_coaster/generators/dataflow_converter/converter_renderer"

module BqCoaster
  module Generators
    class DataflowConverter < Base
      class Context
        attr_reader :renderer

        def initialize(renderer)
          @renderer = renderer
        end

        def definitions
          renderer.definitions
        end

        def field_name(name)
          "#{prefix}.#{name}".sub(/src\./, "").tr(".", "_")
        end

        def nested?(definition)
          !(
            definition.nil? || BqCoaster.edge_properties.any? { |c| definition.include?(c) }
          )
        end

        def prefix
          renderer.prefix
        end

        def render_converter(name, definition)
          ConverterRenderer.new(
            definition,
            prefix: "#{prefix}.#{name}",
            indent: 1
          ).render
        end

        def string?(definition)
          return false if nested?(definition)
          return true if definition.nil?
          if definition.key?(:_original_type)
            definition._original_type == "String"
          else
            return true unless definition.key?(:_type)
            definition._type.casecmp("string").zero?
          end
        end

        def value(name, definition)
          if definition&.key?(:_convert)
            definition._convert.gsub(/%s/, "#{prefix}.#{name}")
          else
            "#{prefix}.#{name}"
          end
        end
      end
    end
  end
end
