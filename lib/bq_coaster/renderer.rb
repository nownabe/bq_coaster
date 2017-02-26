# frozen_string_literal: true

require "erubis"

module BqCoaster
  module Renderer
    private

    def evaluate
      renderer.evaluate(context)
    end

    def renderer
      Erubis::Eruby.new(template)
    end

    def result
      renderer.result(attributes)
    end

    def template
      File.read(template_path)
    end
  end
end
