class OrdersController < ApplicationController

  def index
    conn = Connector.new('localhost', '3000')

    @orders = Order.all
    @orders.each do |order|
      order.user = conn.get_user(order.user_id)
    end
  end

end
