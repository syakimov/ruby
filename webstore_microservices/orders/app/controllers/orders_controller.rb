class OrdersController < ApplicationController

  def index
    @orders = Order.all.map do |order|
      order.merge get_user(order.user_id)
    end
  end

  private

  def get_user(id)
    # get this from coniguration
    client = client('localhost', '3000')
    response = client.get(order.user_id.to_s)
    JSON.parse(response.body).symbolize_keys
  end

  def client(host, port)
    Faraday.new(url: "http://#{host}:#{port}/users") do |faraday|
      faraday.adapter :httpclient
    end
  end

end
