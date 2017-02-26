# frozen_string_literal: true

require "bq_coaster/renderer"
require "bq_coaster/generators/base"
require "bq_coaster/generators/java_class/class_renderer"

module BqCoaster
  module Generators
    class JavaClass < Base
      include Renderer

      def generate
        result
      end

      private

      def attributes
        {
          dataflow:   options[:dataflow],
          java_class: java_class,
          package:    options[:package]
        }
      end

      def class_name
        options[:class_name] || default_class_name
      end

      def default_class_name
        File.basename(definition_file, ".*").camelize
      end

      def java_class
        ClassRenderer.new(
          class_name,
          definitions,
          dataflow: options[:dataflow]
        ).render
      end

      def template_path
        File.expand_path("../java_class/java_class.erb", __FILE__)
      end
    end
  end
end
