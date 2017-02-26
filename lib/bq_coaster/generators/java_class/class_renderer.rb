# frozen_string_literal: true

require "bq_coaster/renderer"
require "bq_coaster/generators/java_class/class_context"

module BqCoaster
  module Generators
    class JavaClass < Base
      class ClassRenderer
        include Renderer

        attr_reader :class_name, :definitions, :dataflow, :static, :indent

        def initialize(class_name, definitions, dataflow: true, static: false, indent: 0)
          @class_name  = class_name
          @definitions = definitions
          @dataflow    = dataflow
          @static      = static
          @indent      = indent
        end

        def render
          evaluate.gsub(/^/, " " * 4 * indent).gsub(/^\s*$/, "").gsub(/\n{3,}/, "\n\n")
        end

        private

        def context
          ClassContext.new(self)
        end

        def template_path
          File.expand_path("../class.erb", __FILE__)
        end
      end
    end
  end
end
