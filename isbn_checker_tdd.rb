require_relative 'isbn_checker.rb'
require 'minitest/autorun'

class Test_for_isbn < Minitest::Test

  def test_for_return_check_digit_10
    assert_equal(7, "0471958697".return_check_digit_10)
    assert_equal(0, "0321146530".return_check_digit_10)
    assert_equal(10, "877195869x".return_check_digit_10)
  end

  def test_for_return_check_digit_13
    assert_equal(9, "9780470059029".return_check_digit_13)
    assert_equal(0, "978-0-13-149505-0".return_check_digit_13)
    assert_equal(0, "978 0 471 48648 0".return_check_digit_13)
  end

  def test_for_verify_true
    assert_equal(true, "877195869x".verify_number)
    assert_equal(true, "0-321-14653-0".verify_number)
    assert_equal(true, "0471958697".verify_number)
    assert_equal(true, "978-0-13-149505-0".verify_number)
  end

  def test_for_verify_false
    assert_equal(false, "4780470059029".verify_number)
    assert_equal(false, "0-321@14653-0".verify_number)
    assert_equal(false, "877195x869".verify_number)
  end

end
