def play_pass(str, n)
    hash = { "0" => "9", "1" => "8", "2" => "7", "3" => "6", "4" => "5", "5" => "4", "6" => "3", "7" => "2", "8" => "1", "9" => "0" }
    code = [] ; answer = []
    abc = ("A".."Z").to_a.join
    arr = str.tr(abc, (abc.chars.rotate(n).join)).split("")

    arr.each do |x|
      if hash.include? x
        code.push(hash[x])
      else
        code.push(x)
      end
    end

    code.join("").each_char.with_index do |c, index|
      if index.even?
        answer.push(c.upcase)
      else
        answer.push(c.downcase)
      end
    end
  return answer.join("").reverse
end
