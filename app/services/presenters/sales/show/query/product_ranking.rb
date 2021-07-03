module Presenters
  module Sales
    class Show
      module Query
        class ProductRanking < Micro::Case
          attribute :sale

          def call!
            Success result: { featured_product: { name: featured_product_name, value: featured_product_value } }
          end

          private

          def featured_product_name
            featured_product_data&.first
          end

          def featured_product_value
            featured_product_data&.second
          end

          def featured_product_data
            product_ranking.max_by { |_, value| value }
          end

          def product_ranking
            @product_ranking ||= Order::Item
              .joins(product: [:merchant], order: [:customer, :sale])
              .where(sale_table[:id].eq(sale.id))
              .group(product_table[:description])
              .order(item_price.desc)
              .sum(item_price)
          end

          def item_price
            Arel::Nodes::Multiplication.new(item_table[:amount], product_table[:price])
          end

          def sale_table
            Sale.arel_table
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
