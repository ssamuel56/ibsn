class String

  def str
    self.gsub(/[- \s]/, "\s" => "", "-" => "")
  end

  def return_check_digit_10()
    ary = str.split("").each_with_index.map {
      |x, index|
      index != 9 ? x.to_i * (index + 1) : 0
    }
    check_digit = ary.sum() % 11
    return check_digit
  end

  def verify_number()
    puts return_check_digit_10
    puts str[-1]
    valid = true if return_check_digit_10() == str[-1].to_i
    valid = true if return_check_digit_10() == 10 && str[-1] == 'x'
    return valid
  end

end
