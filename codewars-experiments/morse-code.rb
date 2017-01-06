def decodeMorse(morseCode)
  string = morseCode.gsub(/\s{2,}/, " ! ")
  string.split(" ").map { |y| MORSE_CODE[y] }.map { |x| x ? x : " " }.join.strip
end

#   def decodeMorse(morseCode)
#     morseCode.strip.split("   ").map { |w| w.split(" ").map { |c| MORSE_CODE[c] }.join }.join(" ")
#   end
