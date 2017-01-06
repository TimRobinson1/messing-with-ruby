def organise(str)
  return (str.split /(?=[A-Z])/).join(" ").strip.gsub(" ", "-").downcase.gsub(/[0-9]/, "").gsub(/^-+/,'')
end

# An example input is "MyCamelIsBig" which will produce "my-camel-is-big"
