require_relative 'isbn_checker.rb'
require 'minitest/autorun'

class Test_for_isbn < Minitest::Test

  def test_for_return_check_digit_10
    assert_equal(7, "0471958697".return_check_digit_10)
    assert_equal(0, "0321146530".return_check_digit_10)
    assert_equal(10, "877195869x".return_check_digit_10)
  end

  def test_for_verify_number
    assert_equal(true, "877195869x".verify_number)
    assert_equal(true, "0-321-14653-0".verify_number)
  end

end
