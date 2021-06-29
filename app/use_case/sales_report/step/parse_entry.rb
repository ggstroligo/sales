module SalesReport
  module Step
    class ParseEntry < Base
      attribute :raw, validates: { kind: String }

      flow self.call!,
           ValidateHeaders,
           ValidateData,
           BuildPayload

      def call!
        Success result: { headers: headers, data: data }
      end

      private

      def rows
        @rows ||= raw.split("\n")
      end

      def data
        rows.drop(1).map { |row| row.split("\t") }
      end

      def headers
        @headers ||= rows.first.split("\t").map { |row| row.parameterize(separator: '_').to_sym }
      end
    end
  end
end
