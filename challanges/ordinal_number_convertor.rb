# frozen_string_literal: true
def ordinalize(num)
  if !num.abs.between?(1, 3)
    num.to_s + 'th'
  else
    case num.abs
    when 1 then num.to_s + 'st'
    when 2 then num.to_s + 'nd'
    when 3 then num.to_s + 'rd'
    end
  end
end
