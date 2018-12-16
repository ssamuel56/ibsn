require 'csv'

class String

  def str
    self.downcase.gsub(/[- \s]/, "\s" => "", "-" => "")
  end

  def return_check_digit_10()
    ary = str.split("").each_with_index.map {
      |x, index|
      index != 9 ? x.to_i * (index + 1) : 0
    }
    return ary.sum() % 11
  end

  def return_check_digit_13()
    ary = str[0..11].split("").each_with_index.map {
      |x, index|
      (index + 1).odd? ? x.to_i * 1 : x.to_i * 3
    }
    return (10 - (ary.sum() % 10)) % 10
  end

  def validation
    [ str.length == 10 && return_check_digit_10() == str[-1].to_i,
    return_check_digit_10() == 10 && str[-1] == 'x',
    return_check_digit_13() == str[-1].to_i ]
  end

  def verify_number()
    validation.include?(true) ? valid = true : valid = false
    valid = false unless str.length == 10 || str.length == 13
    valid = false if str.length == 10 && str[0..8][/\D/]
    valid = false if str.length == 13 && str[0..12][/\D/]
    return valid
  end

end


def isbn_file_maker(file)
  new_file = File.open("isbn_numbers.csv", "w+") {|file| file.truncate(0) }
  CSV.foreach(file) do |row|
    new_file.write(row[1] + ", ")
    new_file.write(row[1].to_s.verify_number() ? "Valid" : "Invalid")
    new_file.write("\n")
  end
  new_file.seek(0)
  text = new_file.read
  new_file.close
  return text
end
