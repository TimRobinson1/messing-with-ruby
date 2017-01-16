# 5 kyu kata for separating and camel-casing strings

def to_camel_case(str)
  if str.match('-') then x = '-' else x = '_' end
  if !str.empty?
    body = str.split(x) ; first = body.shift
    body.map(&:capitalize).unshift(first).join
  else
    str
  end
end

# A very interesting, very succinct solution:
# str.gsub(/[_-](.)/) {"#{$1.upcase}"}
