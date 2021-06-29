module SalesReport
  module Step
    class ParseEntry
      class ValidateData < Base
        attribute :data, validates: { kind: Array }

        COERCIBLE_TYPES = [
          { index: 2, klass: Float },
          { index: 3, klass: Integer }
        ].freeze

        COLUMNS_SIZE = 6

        def call!
          validate!

          return Failure :invalid_data, result: { errors: @errors_object } if @errors_object.any?

          Success :valid_data
        end

        private

        def validate!
          @errors_object = []

          validate_columns_size
          validate_coercible_data
          @errors_object.flatten!.compact!
        end

        def validate_columns_size
          @errors_object << data.map.with_index do |row, line|
            (COLUMNS_SIZE+1).upto(row.size).map do |column|
              error_template('Exceeded Columns', nil, row[column], line, column)
            end
          end
        end

        def validate_coercible_data
          @errors_object << data.map.with_index do |row, line|
            COERCIBLE_TYPES.map do |type|
              klass = type[:klass].to_s
              value_to_cast = row[type[:index]]
              casted = Kernel.send(klass, value_to_cast) rescue false

              error_template('Invalid Type', klass, value_to_cast.class.to_s, line, type[:index]) unless casted
            end
          end
        end

        def error_template(title, expected, given, line, column)
          {
            type: title,
            expected: expected,
            value: given,
            line: line,
            column: column
          }
        end
      end
    end
  end
end
