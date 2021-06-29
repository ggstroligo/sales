module SalesReport
  module Step
    class ParseEntry
      class BuildPayload < Base
        attribute :headers, validates: { kind: Array }
        attribute :data, validates: { kind: Array }

        def call!
          Success :valid_entry, result: { payload: payload }
        end

        private

        def payload
          @payload ||= data.map { |row| Hash[[headers, row].transpose] }
        end
      end
    end
  end
end
