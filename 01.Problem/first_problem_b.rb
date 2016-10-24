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
  convert_between_temperature_units(
    Substance_to_melting_boiling_temp[substance][0], 'C', unit
  )
end

def boiling_point_of_substance(substance, unit)
  convert_between_temperature_units(
    Substance_to_melting_boiling_temp[substance][1], 'C', unit
  )
end

Substance_to_melting_boiling_temp = {
  'water' => [0, 100], 'ethanol' => [-114, 78.37], 'gold' => [1_064, 2_700],
  'silver' => [961.8, 2_162], 'copper' => [1_085, 2_567]
}.freeze
