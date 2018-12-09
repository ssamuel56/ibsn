class String

  def str
    str = self.gsub(/[- \s]/, "\s" => "", "-" => "")
  end

  def return_check_digit_10()
    ary = str.split("").each_with_index.map {
      |x, index|
      index != 9 ? x.to_i * (index + 1) : 0
    }
    check_digit = ary.sum() % 11
    return check_digit
  end

  def return_check_digit_13()
    ary = str[0..11].split("").each_with_index.map {
      |x, index|
      (index + 1).odd? ? x.to_i * 1 : x.to_i * 3
    }
    check_digit = (10 - (ary.sum() % 10)) % 10
    return check_digit
  end

  def verify_number()
    valid = [
    str.length == 10 && return_check_digit_10() == str[-1].to_i,
    return_check_digit_10() == 10 && str[-1] == 'x',
    (return_check_digit_13() == str[-1].to_i)
    ]
    valid.include?(true) ? valid = true : valid = false
    valid = false if str[0..8][/\D/]
    return valid
  end

end
