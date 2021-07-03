module Presenters
  module Sales
    class Show
      module Build
        class SerializedOrders < Micro::Case
          attribute :orders

          def call!
            Success result: { serialized_orders: serialized_orders }
          end

          private

          def serialized_orders
            orders.map do |order|
              serialized(order)
            end
          end

          def serialized(order)
            {
              id: order.id,
              customer: order.customer.name,
              final_value: final_value_of(order)
            }
          end

          def final_value_of(order)
            order.items.inject(0) {|acc, item| acc + (item.product.price * item.amount)}
          end
        end
      end
    end
  end
end
