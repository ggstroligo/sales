module Presenters
  module Sales
    class Index
      module Query
        class SellerRanking < Micro::Case
          def call!
            Success result: { best_seller: { name: best_seller_name, value: best_seller_value } }
          end

          private

          def best_seller_name
            best_seller_data&.first
          end

          def best_seller_value
            best_seller_data&.second
          end

          def best_seller_data
            seller_ranking.max_by { |_, value| value }
          end

          def seller_ranking
            Order::Item.joins(product: :merchant).group(merchant_table[:name]).order(item_price.desc).sum(item_price)
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

        end
      end
    end
  end
end
