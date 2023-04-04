# frozen_string_literal: true

# BEGIN
def fibonacci(num)
  return nil if num.negative?
  return num if num < 2

  prev = 0
  curr = 1

  2.upto(num) do
    prev, curr = curr, prev
    curr += prev
  end

  curr
end
# END
