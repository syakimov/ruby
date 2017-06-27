class Connector
  def initialize(host = 'localhost', port = '3000')
    @client = client(host, port)
  end

  def get_user(id)
    response = @client.get(id.to_s)
    JSON.parse(response.body).symbolize_keys if response.status == 200
  end

  private

  def client(host, port)
    Faraday.new(url: "http://#{host}:#{port}/users") do |faraday|
      faraday.adapter :httpclient
    end
  end
end
