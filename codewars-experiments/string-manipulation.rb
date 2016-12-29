# A series of solutions for replacing all words in a string with 'gravel' or 'rock'.  Not for  running, but referencing.

def rake_garden(garden)
  garden.gsub(/(?!rock\b|gravel\b)\b(\w+)/, 'gravel')
end

# Shortest solution
def rake_garden(garden)
  garden.split.map {|el| (el != 'gravel' && el != 'rock') ? 'gravel' : el}.join(" ")
end


def rake_garden(garden)
  result = []
  garden.split(' ').each do |word|
    result << ((word == 'gravel' || word == 'rock') ? word : 'gravel' )
  end
  result.join(' ')
end


def rake_garden(garden)
  garden.split.map { |item| ["gravel", "rock"].include?(item) ? item : "gravel" }.join(" ")
end


def rake_garden(garden)
  garden = garden.gsub(/\b(?:(?!gravel|rock)\w)+/,'gravel').gsub(/\s+/, ' ').rstrip
end

# I like this solution
def rake_garden(garden)
  garden.split(" ").map do |word|
    if ((word == "gravel") || (word == "rock"))
      word = word
    else
      word = "gravel"
    end
  end.join(" ")
end
