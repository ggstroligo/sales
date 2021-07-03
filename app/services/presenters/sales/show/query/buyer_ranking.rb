module Presenters
  module Sales
    class Show
      module Query
        class BuyerRanking < Micro::Case
          attribute :sale

          def call!
            Success result: { top_buyer: { name: top_buyer_name, value: top_buyer_value } }
          end

          private

          def top_buyer_name
            top_buyer_data&.first
          end

          def top_buyer_value
            top_buyer_data&.second
          end

          def top_buyer_data
            buyer_ranking.max_by { |_, value| value }
          end

          def buyer_ranking
            @buyer_ranking ||= Order::Item
              .joins(product: :merchant, order: [:customer, :sale])
              .where(sale_table[:id].eq(sale.id))
              .group(customer_table[:name])
              .sum(item_price)
          end

          def item_price
            Arel::Nodes::Multiplication.new(item_table[:amount], product_table[:price])
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

          def sale_table
            Sale.arel_table
          end
        end
      end
    end
  end
end
