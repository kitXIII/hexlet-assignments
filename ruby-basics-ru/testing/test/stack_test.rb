# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def test_push
    stack = Stack.new

    assert { stack.to_a.empty? }

    stack.push! :item1
    assert { stack.to_a == [:item1] }

    stack.push! :item2
    assert { stack.to_a == %i[item1 item2] }

    stack.push! :item2
    assert { stack.to_a == %i[item1 item2 item2] }
  end

  def test_pop
    stack = Stack.new %i[item1 item2]

    assert { stack.pop! == :item2 }
    assert { stack.to_a == %i[item1] }

    assert { stack.pop! == :item1 }
    assert { stack.to_a.empty? }
  end

  def test_clean
    stack = Stack.new %i[item1 item2]

    refute { stack.to_a.empty? }

    stack.clear!

    assert { stack.to_a.empty? }
  end

  def test_empty
    stack = Stack.new

    assert { stack.empty? }

    stack.push! :item1
    refute { stack.empty? }

    stack.pop!
    assert { stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
