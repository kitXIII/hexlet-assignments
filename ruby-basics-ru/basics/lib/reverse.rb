# frozen_string_literal: true

# BEGIN
def reverse(str)
  return '' if str.empty?

  result = []
  str.size.downto(1) { |i| result << str[i - 1] }

  result.join
end
# END
