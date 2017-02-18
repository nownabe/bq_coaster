# frozen_string_literal: true

require "thor"

module BqCoaster
  class Cli < Thor
    desc "schema <definition_file>", "Generate BigQuery schema JSON"
    def schema(definition_file)
      require "bq_coaster/generators/schema"
      puts Generators::Schema.new(definition_file).generate
    end
  end
end
