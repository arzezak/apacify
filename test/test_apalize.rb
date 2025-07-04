require "test_helper"

class TestApalize < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Apalize::VERSION
  end
end
