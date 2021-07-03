class SalesController < ApplicationController
  include SalesHelper

  before_action :check_file, only: :create

  def index
    Presenters::Sales::Index
      .call
      .on_success do |result|
        @sales = result.data[:sales]
        @total_gross_income = result.data[:total_gross_income]
        @mean_avg_per_sale = result.data[:mean_avg_per_sale]
        @best_seller = result.data[:best_seller]
        @top_buyer = result.data[:top_buyer]
      end
  end

  def show
    Presenters::Sales::Show
      .call(sale_id: params[:id])
      .on_success do |result|
        @sale = result.data[:sale]
        @orders = result.data[:orders]
        @sale_income = result.data[:sale_income]
        @average_ticket = result.data[:average_ticket]
        @featured_product = result.data[:featured_product]
        @top_buyer = result.data[:top_buyer]
      end
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
