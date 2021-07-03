module SalesReport
  class Collect < Base
    attribute :raw, validates: { kind: String }

    flow Step::ParseEntry,
         Step::PersistSaleData

  end
end
