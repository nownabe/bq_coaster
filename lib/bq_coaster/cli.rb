# frozen_string_literal: true

require "thor"
require "bq_coaster/ext/string"

module BqCoaster
  class Cli < Thor
    desc "schema <definition_file>", "Generate BigQuery schema JSON"
    def schema(definition_file)
      require "bq_coaster/generators/schema"
      puts Generators::Schema.new(definition_file, options).generate
    end

    desc "java_class <definition_file>", "Generate Java class"
    option :dataflow, type: :boolean, desc: "with Dataflow coder"
    option :class_name, type: :string, desc: "Java class name"
    option :package, type: :string, desc: "Java package name"
    def java_class(definition_file)
      require "bq_coaster/generators/java_class"
      puts Generators::JavaClass.new(definition_file, options).generate
    end
  end
end
