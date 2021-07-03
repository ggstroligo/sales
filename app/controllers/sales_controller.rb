class SalesController < ApplicationController
  include SalesHelper

  before_action :check_file, only: :create

  def index
    merchant_table = Merchant.arel_table
    product_table = Product.arel_table
    item_table = Order::Item.arel_table
    customer_table = Customer.arel_table
    item_price = Arel::Nodes::Multiplication.new(item_table[:amount], product_table[:price])
    sales_values = Sale.joins(orders: { items: :product }).group(:id).sum(item_price)

    @total_gross_income = sales_values.values.sum
    @mean_avg_per_sale = sales_values.values.sum / sales_values.size if sales_values.size.positive?

    buyer_ranking = Order::Item.joins(product: :merchant, order: :customer).group(customer_table[:id]).sum(item_price)
    top_buyer = buyer_ranking.max_by { |_, v| v }
    @top_buyer = Customer.find(top_buyer.first).name
    @top_buyer_value = top_buyer.last

    ranking_sellers = Order::Item.joins(product: :merchant).group(merchant_table[:id]).order(item_price.desc).sum(item_price)
    top_seller = ranking_sellers.max_by { |_, v| v }
    @top_seller = Merchant.find(top_seller.first).name
    @top_seller_value = top_seller.last

    @sales = Sale.all
  end

  def create
    SalesReport::Collect
      .call(raw: extracted_data)
      .on_success { |result| flash[:success] = [success_msg(result.data[:sale].orders.count)] }
      .on_failure { |result| flash[:alert] = result.data[:errors].map { |error| error_msg(error) } }
      .then do |result|
        return redirect_to sales_path if result.success?

        redirect_to new_sale_path
      end
  end

  private

  def sales_params
    params.require(:report_file)
  end
end
