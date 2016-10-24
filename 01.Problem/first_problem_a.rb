def convert_between_temperature_units(degrees, input_unit, output_unit)
  degrees = convert_to_celsius(degrees, input_unit) if input_unit != 'C'
  output_unit == 'C' ? degrees : convert_from_celsius(degrees, output_unit)
end

def convert_to_celsius(degrees, input_unit)
  input_unit == 'K' ? degrees - 273.15 : (degrees + 40) / 1.8 - 40
end

def convert_from_celsius(degrees, output_unit)
  output_unit == 'K' ? degrees + 273.15 : (degrees + 40) * 1.8 - 40
end

def melting_point_of_substance(substance, unit)
  dic = {
    'water' => 0, 'ethanol' => -114, 'gold' => 1_064,
    'silver' => 961.8, 'copper' => 1_085
  }

  convert_between_temperature_units(dic[substance], 'C', unit)
end

def boiling_point_of_substance(substance, unit)
  dic = {
    'water' => 100, 'ethanol' => 78.37, 'gold' => 2_700,
    'silver' => 2_162, 'copper' => 2_567
  }

  convert_between_temperature_units(dic[substance], 'C', unit)
end
