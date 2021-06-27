class SalesController < ApplicationController
  include SalesHelper

  def index
    @sales = Sale.all
  end

  def new

  end

  def create
    SalesReport::Collect
      .call(raw: sales_file.read)
      .on_success { |result| flash[:success] = [success_msg(result.data[:payload].size)] }
      .on_failure { |result| flash[:alert] = result.data[:errors].map { |error| error_msg(error) } }
      .then { redirect_to sales_path }
  end

  private

  def sales_file
    params.require(:report_file).open
  end
end
