# frozen_string_literal: true

# BEGIN
def fizz_buzz(start, stop)
  return nil if start > stop

  to_fizz_buzz = proc do |i|
    result = ''

    result += 'Fizz' if (i % 3).zero?
    result += 'Buzz' if (i % 5).zero?

    result.empty? ? i : result
  end

  start.upto(stop).to_a.map(&to_fizz_buzz).join(' ')
end
# END
