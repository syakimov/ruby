require('./second_problem_a.rb')

describe 'Hash#fetch_deep' do
  it 'can look up simple values' do
    input = {meal: 'musaka'}

    expect(input.fetch_deep('meal')).to eq 'musaka'
  end

  it 'can look up in nested objects' do
    input = { menu: {
      breakfast: 'banana',
      "lunch" => 'musaka',
      dinner: ["rakia", "mandja","torta"]
      }
    }

    expect(input.fetch_deep('menu.breakfast')).to eq 'banana'
    expect(input.fetch_deep('menu.lunch')).to eq 'musaka'
    expect(input.fetch_deep('menu.dinner.0')).to eq 'rakia'
    expect(input.fetch_deep('menu.dinner.1')).to eq 'mandja'
    expect(input.fetch_deep('menu.dinner.2')).to eq 'torta'
  end

  it 'can look up in other nested objects' do
    input = { menu: {
      breakfast: [:banana],
      :lunch => :musaka,
      "dinner": ["rakia", "mandja", :torta]
      }
    }

    expect(input.fetch_deep('menu.breakfast.0')).to eq :banana
    expect(input.fetch_deep('menu.lunch')).to eq :musaka
    expect(input.fetch_deep('menu.dinner.0')).to eq 'rakia'
    expect(input.fetch_deep('menu.dinner.1')).to eq 'mandja'
    expect(input.fetch_deep('menu.dinner.2')).to eq :torta
  end

  it 'can look up in really complicated objects' do
    input = { menu: {
      breakfast: [:banana],
      :lunch => :musaka,
      "dinner": [{
        "pre": {
          "soup": "chicken",
          salad: :caesar
        }
        }, "mandja", :torta]
      }
    }

    expect(input.fetch_deep('menu.dinner.0.pre.soup')).to eq "chicken"
    expect(input.fetch_deep('menu.dinner.0.pre.salad')).to eq :caesar
  end
end

describe 'Hash#reshape' do
  it 'can rename fields' do
    input = {name: 'Georgi'}
    shape = {first_name: 'name'}
    output = {first_name: 'Georgi'}

    expect(input.reshape(shape)).to eq output
  end

  it 'can reshape complex objects' do
    input = {dessert: {type: 'cake', variant: 'chocolate'}}
    shape = {food: 'dessert.type', taste: 'dessert.variant'}
    output = {food: 'cake', taste: 'chocolate'}

    expect(input.reshape(shape)).to eq output
  end
end

describe 'Array#reshape' do
  it 'can rename fields in each element' do
    input = [
      {item: 'musaka'}
    ]

    shape = {meal: 'item'}

    expect(input.reshape(shape)).to eq [
      {meal: 'musaka'}
    ]
  end

  it 'can reshape complex arrays' do
    input = [
      {item: {type: 'musaka', price: 4.0, quantity: 30}},
      {item: {type: 'cake',   price: 3.5, quantity: 20}}
    ]

    shape = {food: 'item.type', price: 'item.price'}

    expect(input.reshape(shape)).to eq [
      {food: 'musaka', price: 4.0},
      {food: 'cake', price: 3.5}
    ]
  end
end
