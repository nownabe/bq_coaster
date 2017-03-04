# frozen_string_literal: true

require "json"
require "bq_coaster"
require "bq_coaster/generators/base"

module BqCoaster
  module Generators
    class Schema < Base
      def generate
        JSON.pretty_generate(
          definitions.map { |n, d| parse(n, d) }.flatten
        )
      end

      private

      def nested?(definition)
        !(
          definition.nil? || BqCoaster.edge_properties.any? { |c| definition.key?(c) }
        )
      end

      def parse(name, definition, prefix = "")
        if nested?(definition)
          definition.map { |n, d| parse(n, d, "#{prefix}#{name}_") }
        else
          {
            name: "#{prefix}#{name}",
            type: (definition&._type || "string").upcase,
            mode: (definition&._mode || "nullable").upcase
          }
        end
      end
    end
  end
end
