class Base < Micro::Case
  module Validations
    RelationOf = lambda do |kind|
      ->(value) { value.is_a?(::ActiveRecord::Relation) && value.klass == kind }
    end
  end
end