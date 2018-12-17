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
    assert_equal(true, "99921-58-10-7".verify_number)
    assert_equal(true, "960-425-059-0".verify_number)
    assert_equal(true, "85-359-0277-5".verify_number)
    assert_equal(true, "0000000000000".verify_number)
  end

  def test_for_verify_false
    assert_equal(false, "4780470059029".verify_number)
    assert_equal(false, "0-321@14653-0".verify_number)
    assert_equal(false, "877195x869".verify_number)
    assert_equal(false, "877197x869".verify_number)
    assert_equal(false, "48565111x869".verify_number)
    assert_equal(false, "1 2 3 4 5 6 - 77-9x".verify_number)
  end

#   def test_isbn_file_maker
#     assert_equal(" 9780470059029, Valid
#  4780470059029, Invalid
#  978 0 471 48648 0, Valid
#  978-0596809485, Valid
#  978-0-13-149505-0, Valid
#  978-0-262-13472-9, Valid
#  7465905, Invalid
#  00000000, Invalid
#  7987022-78962-ds-22, Invalid
#  0471958697, Valid
#  0 471 60695 2, Valid
#  0-470-84525-2, Valid
#  0-321-14653-0, Valid
#  877195869x, Valid
#  877195x869, Invalid
#  877195869xx, Invalid
#  877195@869x, Invalid
# ", isbn_file_maker("isbn.csv"))
#   end

  def test_for_isbn_other
    assert_equal("", isbn_file_maker("isbn_other.csv"))
  end

end
