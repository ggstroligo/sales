module Presenters
  module Sales
    class Index < Micro::Case

      attributes :total_income, :best_seller, :top_buyer

      flow Query::TotalIncome,
           Query::SellerRanking,
           Query::BuyerRanking,
           self.call!

      def call!
        Success result: {
          total_gross_income: total_gross_income,
          mean_avg_per_sale: mean_avg_per_sale,
          best_seller: best_seller,
          top_buyer: top_buyer,
          sales: Sale.all
        }
      end

      private

      def total_gross_income
        total_income.values.sum
      end

      def mean_avg_per_sale
        return 0 if total_income.size.zero?

        total_income.values.sum / total_income.size
      end
    end
  end
end
