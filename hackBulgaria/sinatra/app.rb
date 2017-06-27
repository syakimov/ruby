require 'sinatra'

get '/' do
  [404, ['Text']]
  # "<h1>Hallo welt</h1>"
end

get '/hello/:name' do
  name = params[:name]
  if name == 'Petur'
    [404, 'text']
  else
    "Hello #{name}"
  end
end
