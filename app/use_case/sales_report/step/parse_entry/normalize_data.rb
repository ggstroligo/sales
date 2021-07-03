module SalesReport
  module Step
    class ParseEntry
      class NormalizeData < Base
        attribute :data, validates: { kind: Array }

        def call!
          Success :valid_entry, result: { orders: normalized_payload }
        end

        private

        def normalized_payload
          @normalized_payload ||= orders_grouped_by_customer.map do |order|
            {
              customer: order[0],
              items: build_items(order[1])
            }
          end
        end

        def orders_grouped_by_customer
          data.group_by { |order| order[0] }
        end

        def build_items(items)
          group_by_price_name_and_merchant_of(items).map do |item_data|
            normalized_item(item_data)
          end
        end

        def group_by_price_name_and_merchant_of(items)
          items.group_by { |item| [item[1], item[2], item[5]] }.values
        end

        def normalized_item(data)
          {
            description: data.first[1],
            price: data.first[2].to_f,
            amount: data.sum(0) { |i| i[3].to_i },
            merchant: { address: data.first[4], name: data.first[5] }
          }
        end
      end
    end
  end
end
