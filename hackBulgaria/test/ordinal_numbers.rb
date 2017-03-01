def cool_numbers(num)
  return num.to_s + 'th' if num.abs == 11 || num.abs == 12 || num.abs == 13
  case (num % 10).abs
  when 1 then num.to_s + 'st'
  when 2 then num.to_s + 'nd'
  when 3 then num.to_s + 'rd'
  else num.to_s + 'th'
  end
end
