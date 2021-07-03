module Presenters
  module Sales
    class Show
      module Query
        class FindSaleAndOrders < Micro::Case
          attribute :sale_id

          def call!
            return Failure :not_found unless sale

            Success result: { sale: sale, orders: sale.orders }
          end

          private

          def sale
            Sale.includes(orders: [:customer, :items]).find(sale_id)
          end
        end
      end
    end
  end
end
