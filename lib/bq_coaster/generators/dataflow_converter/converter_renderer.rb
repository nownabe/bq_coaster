# frozen_string_literal: true

require "bq_coaster/generators/dataflow_converter/context"

module BqCoaster
  module Generators
    class DataflowConverter < Base
      class ConverterRenderer
        include Renderer

        attr_reader :definitions, :prefix, :indent

        def initialize(definitions, prefix: "", indent: 0)
          @definitions = definitions
          @prefix      = prefix
          @indent      = indent
        end

        def render
          evaluate.gsub(/^/, " " * 4 * indent)
        end

        private

        def context
          Context.new(self)
        end

        def template_path
          File.expand_path("../converter.erb", __FILE__)
        end
      end
    end
  end
end
