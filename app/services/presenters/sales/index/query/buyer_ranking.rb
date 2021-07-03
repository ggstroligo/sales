module Presenters
  module Sales
    class Index
      module Query
        class BuyerRanking < Micro::Case
          def call!
            Success result: { top_buyer: { name: best_buyer_name, value: best_buyer_value } }
          end

          private

          def best_buyer_name
            best_buyer_data&.first
          end

          def best_buyer_value
            best_buyer_data&.second
          end

          def best_buyer_data
            buyer_ranking.max_by { |_, value| value }
          end

          def buyer_ranking
            Order::Item.joins(product: :merchant, order: :customer).group(customer_table[:name]).sum(item_price)
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

        end
      end
    end
  end
end
