require('./first_problem.rb')

describe '#convert_between_temperature_units' do
  it 'is defined and functions for simple values' do
    expect(convert_between_temperature_units(0, 'C', 'K'))
      .to be_within(0.0001).of(273.15)
    expect(convert_between_temperature_units(1, 'C', 'F'))
      .to be_within(0.0001).of(33.8)
  end
end

describe '#melting_point_of_substance' do
  it 'knows the melting point of water' do
    expect(melting_point_of_substance('water', 'C')).to be_within(0.01).of(0)
    expect(melting_point_of_substance('water', 'K'))
      .to be_within(0.01).of(273.15)
  end
end

describe '#boiling_point_of_substance' do
  it 'knows the boiling point of water' do
    expect(boiling_point_of_substance('water', 'C')).to be_within(0.01).of(100)
    expect(boiling_point_of_substance('water', 'K'))
      .to be_within(0.01).of(373.15)
  end
end

describe '#convert_between_temperature_units' do
  it 'converts from Kelvin' do
    expect(convert_between_temperature_units(1.2, 'K', 'F'))
      .to be_within(0.01).of(-457.51)
    expect(convert_between_temperature_units(4.2, 'K', 'C'))
      .to be_within(0.01).of(-268.95)
    expect(convert_between_temperature_units(1, 'K', 'K')).to eq(1)
    expect(convert_between_temperature_units(0, 'K', 'K')).to eq(0)
  end

  it 'converts from Celsius' do
    expect(convert_between_temperature_units(0, 'C', 'K'))
      .to be_within(0.0001).of(273.15)
    expect(convert_between_temperature_units(1, 'C', 'F'))
      .to be_within(0.0001).of(33.8)
    expect(convert_between_temperature_units(1.2, 'C', 'F'))
      .to be_within(0.01).of(34.16)
    expect(convert_between_temperature_units(1.2, 'C', 'K'))
      .to be_within(0.01).of(274.35)
    expect(convert_between_temperature_units(1, 'C', 'C')).to eq(1)
    expect(convert_between_temperature_units(0, 'C', 'C')).to eq(0)
  end

  it 'converts from Fahrenheit' do
    expect(convert_between_temperature_units(1.2, 'F', 'C'))
      .to be_within(0.01).of(-17.11)
    expect(convert_between_temperature_units(4.2, 'F', 'K'))
      .to be_within(0.01).of(257.70)
    expect(convert_between_temperature_units(1, 'F', 'F')).to eq(1)
    expect(convert_between_temperature_units(0, 'F', 'F')).to eq(0)
  end
end

describe '#melting_point_of_substance' do
  it 'knows the melting point of water' do
    expect(melting_point_of_substance('water', 'C')).to be_within(0.01).of(0)
    expect(melting_point_of_substance('water', 'K'))
      .to be_within(0.01).of(273.15)
    expect(melting_point_of_substance('water', 'F')).to eq(32)
  end

  it 'knows the melting point of ethanol' do
    expect(melting_point_of_substance('ethanol', 'C')).to eq(-114)
    expect(melting_point_of_substance('ethanol', 'K'))
      .to be_within(0.01).of(159.15)
    expect(melting_point_of_substance('ethanol', 'F'))
      .to be_within(0.01).of(-173.2)
  end

  it 'knows the melting point of gold' do
    expect(melting_point_of_substance('gold', 'C')).to eq(1064)
    expect(melting_point_of_substance('gold', 'K'))
      .to be_within(0.01).of(1337.15)
    expect(melting_point_of_substance('gold', 'F'))
      .to be_within(0.01).of(1947.2)
  end

  it 'knows the melting point of silver' do
    expect(melting_point_of_substance('silver', 'C')).to eq(961.8)
    expect(melting_point_of_substance('silver', 'K'))
      .to be_within(0.01).of(1234.95)
    expect(melting_point_of_substance('silver', 'F'))
      .to be_within(0.01).of(1763.24)
  end

  it 'knows the melting point of copper' do
    expect(melting_point_of_substance('copper', 'C')).to eq(1085)
    expect(melting_point_of_substance('copper', 'K'))
      .to be_within(0.01).of(1358.15)
    expect(melting_point_of_substance('copper', 'F'))
      .to be_within(0.01).of(1985)
  end
end

describe '#boiling_point_of_substance' do
  it 'knows the boiling point of water' do
    expect(boiling_point_of_substance('water', 'C')).to be_within(0.01).of(100)
    expect(boiling_point_of_substance('water', 'K'))
      .to be_within(0.01).of(373.15)
    expect(boiling_point_of_substance('water', 'F')).to eq(212)
  end

  it 'knows the boiling point of ethanol' do
    expect(boiling_point_of_substance('ethanol', 'C'))
      .to be_within(0.01).of(78.37)
    expect(boiling_point_of_substance('ethanol', 'K'))
      .to be_within(0.01).of(351.52)
    expect(boiling_point_of_substance('ethanol', 'F'))
      .to be_within(0.001).of(173.066)
  end

  it 'knows the boiling point of gold' do
    expect(boiling_point_of_substance('gold', 'C')).to be_within(0.01).of(2700)
    expect(boiling_point_of_substance('gold', 'K'))
      .to be_within(0.01).of(2973.15)
    expect(boiling_point_of_substance('gold', 'F')).to eq(4892)
  end

  it 'knows the boiling point of silver' do
    expect(boiling_point_of_substance('silver', 'C'))
      .to be_within(0.01).of(2162)
    expect(boiling_point_of_substance('silver', 'K'))
      .to be_within(0.01).of(2435.15)
    expect(boiling_point_of_substance('silver', 'F'))
      .to be_within(0.01).of(3923.6)
  end

  it 'knows the boiling point of copper' do
    expect(boiling_point_of_substance('copper', 'C'))
      .to be_within(0.01).of(2567)
    expect(boiling_point_of_substance('copper', 'K'))
      .to be_within(0.01).of(2840.15)
    expect(boiling_point_of_substance('copper', 'F'))
      .to be_within(0.01).of(4652.6)
  end
end
