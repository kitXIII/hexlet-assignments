# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  def test_new_stack_is_empty
    stack = Stack.new

    assert { stack.to_a == [] }
    assert stack.empty?
  end

  def test_push_adds_an_element
    stack = Stack.new

    stack.push! 'First'
    assert { stack.to_a == ['First'] }
    assert { stack.size == 1 }

    stack.push! 'Second'
    assert { stack.to_a == %w[First Second] }
    assert { stack.size == 2 }

    refute stack.empty?
  end

  def test_pop_removes_last_element
    stack = Stack.new

    stack.push! 'First'
    stack.push! 'Second'

    stack.pop!

    assert { stack.to_a == ['First'] }
    assert { stack.size == 1 }

    stack.pop!

    assert { stack.to_a == [] }
    assert stack.empty?
  end

  def test_clear_removes_all_elements
    stack = Stack.new

    stack.push! 'First'
    stack.push! 'Second'

    stack.clear!

    assert { stack.to_a == [] }
    assert stack.empty?
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
