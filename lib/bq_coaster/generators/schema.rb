# frozen_string_literal: true

require "json"
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
          definition.nil? ||
          definition.key?(:type) ||
          definition.key?(:mode) ||
          definition.key?(:pre)
        )
      end

      def parse(name, definition, prefix = "")
        if nested?(definition)
          definition.map { |n, d| parse(n, d, "#{name}_") }
        else
          {
            name: "#{prefix}#{name}",
            type: (definition&.type || "string").upcase,
            mode: (definition&.mode || "nullable").upcase
          }
        end
      end
    end
  end
end
