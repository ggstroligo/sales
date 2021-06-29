module SalesReport
  module Step
    class ParseEntry
      class ValidateHeaders < Base
        attribute :headers, validates: { kind: Array }

        EXPECTED_HEADER = [
          :purchaser_name,
          :item_description,
          :item_price,
          :purchase_count,
          :merchant_address,
          :merchant_name
        ].freeze

        def call!
          return Failure :invalid_headers, result: { errors: error_object } if error_object.any?

          Success :valid_headers
        end

        def error_object
          @error_object ||= (missing_keys + unexpected_keys).uniq
        end

        def missing_keys
          EXPECTED_HEADER.map.with_index do |value, index|
            { type: 'Cabeçalho incorreto', column: index, expected: value, value: headers[index] } unless value == headers[index]
          end.compact
        end

        def unexpected_keys
          headers.map.with_index do |value, index|
            { type: 'Cabeçalho incorreto', column: index, expected: EXPECTED_HEADER[index], value: value } unless value == EXPECTED_HEADER[index]
          end.compact
        end
      end
    end
  end
end
