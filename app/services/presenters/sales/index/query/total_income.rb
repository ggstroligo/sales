module Presenters
  module Sales
    class Index
      module Query
        class TotalIncome < Micro::Case
          def call!
            Success result: { total_income: total_income }
          end

          private

          def total_income
            Sale.joins(orders: { items: :product }).group(:id).sum(item_price)
          end

          def item_price
            Arel::Nodes::Multiplication.new(item_table[:amount], product_table[:price])
          end

          def merchant_table
            Merchant.arel_table
          end

          def product_table
            Product.arel_table
          end

          def item_table
            Order::Item.arel_table
          end

          def customer_table
            Customer.arel_table
          end

        end
      end
    end
  end
end
