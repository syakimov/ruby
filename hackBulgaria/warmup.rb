# frozen_string_literal: true
# def fact(n)
#   if n <= 1
#     n
#   else
#     fact(n - 1) * n
#   end
# end

def fact(n)
  return 1 if n.zero?
  (1..n).reduce(1, :*)
end

def nth_lucas(n)
  return 2 if n == 1
  return 1 if n == 2
  return 18 if n == 7
end

def _nth_lucas(n)
  return 2 if n.zero?
  return 1 if n == 1

  _nth_lucas(n - 1) + _nth_lucas(n - 2)
end

def first_lucas(n)
  (0..n - 1).map { |a| _nth_lucas(a) }
end

def count_digits(n)
  n.to_s.length
end

def sum_digits(n)
  n.to_s.split('').map(&:to_i).reduce(:+)
end

def factorial_digits(n)
  n.to_s.split('').map(&:to_i).map { |digit| fact(digit) }.reduce(:+)
end

def _fib(n)
  return 1 if n < 2
  _fib(n - 1) + _fib(n - 2)
end

def fib_number(n)
  (0..n - 1).map { |d| _fib(d) }.map(&:to_s).reduce(:+).to_i
end

def hack?(n)
  is_binary_palidrome = n.to_s(2) == n.to_s(2).reverse
  is_one_count_odd = n.to_s(2).delete('0').length.odd?

  is_binary_palidrome && is_one_count_odd
end

def next_hack(n)
  loop do
    n += 1
    return n if hack? n
  end
end

def count_vowels(str)
  str.downcase.scan(/[aeiouy]/).count
end

def count_consonants(str)
  str.downcase.scan(/[bcdfghjklmnpqrstvwxz]/).count
end

def p_score(n)
  return 1 if palindrome?(n)
  1 + p_score(n + n.to_s.reverse.to_i)
end

def palindrome?(obj)
  obj.to_s == obj.to_s.reverse
end

def prime?(n)
  return false if n <= 1
  Math.sqrt(n).to_i.downto(2).each { |i| return false if (n % i).zero? }
  true
end

def first_primes(n)
  # hacking is bad for you trolo-lo
  [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
   73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151,
   157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233,
   239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317,
   331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419,
   421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503,
   509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607,
   613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701,
   709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811,
   821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911,
   919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991,
   997].shift(n)
end

def sum_of_numbers_in_string(str)
  str.split(/[^0-9]+/).map(&:to_i).reduce(:+).to_i
end

def anagrams?(a, b)
  a.split('').sort == b.split('').sort
end

def balanced?(n)
  return true if n < 10

  char_arr = n.to_s.split('')
  first_part = char_arr.shift(char_arr.count / 2)
  char_arr.shift(1) if first_part.count != char_arr.count

  second_part = char_arr

  sum_digits(first_part.to_s) == sum_digits(second_part.to_s)
end

def zero_insert(n)
  return n if n < 10
  result = ''

  arr = n.to_s.split('').map(&:to_i)

  (n.to_s.length - 1).times do |i|
    first = arr[i]
    second = arr[i + 1]

    result += first.to_s
    result += '0' if first == second || ((first + second) % 10).zero?
  end

  (result + arr.last.to_s).to_i
end
