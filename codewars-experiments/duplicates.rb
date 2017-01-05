# Level 6 Kata to count duplicates

def duplicate_count(text)
  if text.downcase! == nil
    text.split("").select { |char| text.count(char) > 1 }.uniq.count
  else
    (text.downcase).split("").select { |char| text.count(char) > 1 }.uniq.count
  end
end

#       def duplicate_count(text)
#         ('a'..'z').count { |c| text.downcase.count(c) > 1 }
#       end
