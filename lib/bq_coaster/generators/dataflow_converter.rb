# frozen_string_literal: true

require "bq_coaster/renderer"
require "bq_coaster/generators/base"
require "bq_coaster/generators/dataflow_converter/converter_renderer"

module BqCoaster
  module Generators
    class DataflowConverter < Base
      include Renderer

      def generate
        result
      end

      private

      def attributes
        {
          class_name:   options[:class_name],
          converter:    converter,
          source_class: options[:source_class],
          package:      options[:package]
        }
      end

      def converter
        ConverterRenderer.new(
          definitions,
          prefix: "src",
          indent: 2
        ).render.gsub(/^\s*\n/, "")
      end

      def template_path
        File.expand_path("../dataflow_converter/class.erb", __FILE__)
      end
    end
  end
end
