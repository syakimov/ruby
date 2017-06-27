class OrdersController < ApplicationController

  def index
    conn = Connector.new('localhost', '3000')

    @orders = Order.all.map do |order|
      order.merge conn.get_user(order.user_id)
    end
  end

end
