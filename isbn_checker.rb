class Number_check

  def return_check_digit(number)
    n = 1
    ary = number.split("").each_with_index.map { |x, index|
      p index
       x.to_i * (index + 1)
    }
    p ary
    check_digit = ary.sum%11
    return check_digit
  end

end
