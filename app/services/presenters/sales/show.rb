module Presenters
  module Sales
    class Show < Micro::Case
      attribute :sale_id
      attributes :sale_income, :featured_product, :top_buyer, :serialized_orders, :sale

      flow Query::FindSaleAndOrders,
           Query::SaleIncome,
           Query::ProductRanking,
           Query::BuyerRanking,
           Build::SerializedOrders,
           self.call!

      def call!
        Success result: {
          sale: sale,
          orders: serialized_orders,
          sale_income: sale_income_value,
          average_ticket: average_ticket,
          featured_product: featured_product,
          top_buyer: top_buyer
        }
      end

      private

      def sale_income_value
        sale_income.values.sum
      end

      def average_ticket
        return 0 if sale_income.size.zero?

        sale_income.values.sum / sale_income.size
      end
    end
  end
end
