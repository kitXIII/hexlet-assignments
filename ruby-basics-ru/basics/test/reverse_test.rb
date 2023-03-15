# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/reverse'

class ReverseTest < Minitest::Test
  def test_reverse
    assert { reverse('Hexlet') == 'telxeH' }
    assert { reverse(' Hexlet One Love!') == '!evoL enO telxeH ' }
    assert { reverse('Awe-so-me-ness') == 'ssen-em-os-ewA' }
  end
end
