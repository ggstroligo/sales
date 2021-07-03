module SalesReport
  module Step
    class PersistSaleData < Base
      attribute :orders, validates: { kind: Enumerable }

      def call!
        persist!
        Success :persisted, result: { sale: @sale }
      end

      private

      def persist!
        ActiveRecord::Base.transaction do
          create_sale!
        end
      end

      def create_sale!
        @sale = Sale.create.tap do |sale|
          create_orders_of(sale)
        end
      end

      def create_orders_of(sale)
        sale.orders << orders.map do |order_data|
          Order.create.tap do |order|
            order.customer = Customer.find_or_create_by(name: order_data[:customer])
            order.items << create_items_of(order, order_data)
          end
        end
      end

      def create_items_of(order, data)
        order.items << data[:items].map do |item_data|
          Order::Item.new.tap do |item|
            item.amount = item_data[:amount]
            item.order = order
            item.product = retrieve_product_of(item_data)
          end
        end
      end

      def retrieve_merchant_of(item_data)
        merchant_attributes = item_data[:merchant]
        Merchant.find_or_create_by(name: merchant_attributes[:name], address: merchant_attributes[:address])
      end

      def retrieve_product_of(item_data)
        Product.find_or_create_by(
          description: item_data[:description],
          price: item_data[:price],
          merchant: retrieve_merchant_of(item_data)
        )
      end


    end
  end
end
