require_relative 'isbn_checker.rb'
require 'minitest/autorun'

class Test_for_isbn < Minitest::Test

  def setup
    @function = Number_check.new
  end

  def test_for_return_check_digit
    number = "047195869"
    assert_equal(7, @function.return_check_digit(number))
  end

end
