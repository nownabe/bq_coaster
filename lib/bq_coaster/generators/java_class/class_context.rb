# frozen_string_literal: true

require "bq_coaster"
require "bq_coaster/generators/java_class/class_renderer"

module BqCoaster
  module Generators
    class JavaClass < Base
      class ClassContext
        attr_reader :renderer

        def initialize(renderer)
          @renderer = renderer
        end

        def class_name
          renderer.class_name
        end

        def definitions
          renderer.definitions
        end

        def dataflow?
          !!renderer.dataflow
        end

        def nested?(definition)
          !(
            definition.nil? || BqCoaster.edge_properties.any? { |c| definition.key?(c) }
          )
        end

        def render_class(class_name, definitions)
          ClassRenderer.new(
            class_name,
            definitions,
            dataflow: renderer.dataflow,
            static: true,
            indent: 1
          ).render
        end

        def static?
          !!renderer.static
        end

        def type(definition)
          return "String" unless definition
          return definition[:_original_type] if definition[:_original_type]
          case definition[:_type]
          when "integer"
            "Long"
          when "float"
            "Double"
          when "timestamp"
            "Long"
          else
            "String"
          end
        end
      end
    end
  end
end
