# frozen_string_literal: true

require "yaml"
require "hashie/mash"

module BqCoaster
  module Generators
    class Base
      attr_reader :definition_file

      def initialize(definition_file)
        @definition_file = definition_file
      end

      private

      def definitions
        @definitions ||=
          Hashie::Mash.new(YAML.load_file(definition_file))
      end
    end
  end
end
