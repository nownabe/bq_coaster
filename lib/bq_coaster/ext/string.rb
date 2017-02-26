# frozen_string_literal: true

class String
  def camelize
    gsub(/^(.)|[-_](.)/) { ($1 || $2).upcase }
  end
end
