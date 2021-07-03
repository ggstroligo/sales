module Presenters
  module Sales
    class Show
      module Query
        class SaleIncome < Micro::Case
          attribute :sale

          def call!
            Success result: { sale_income: sale_income }
          end

          private

          def sale_income
            @sale_income ||= Order
              .joins(:customer, items: [:product])
              .where(sale: sale)
              .group(customer_table[:name])
              .sum(item_price)
          end

          def item_price
            Arel::Nodes::Multiplication.new(item_table[:amount], product_table[:price])
          end

          def customer_table
            Customer.arel_table
          end

          def product_table
            Product.arel_table
          end

          def item_table
            Order::Item.arel_table
          end
        end
      end
    end
  end
end
