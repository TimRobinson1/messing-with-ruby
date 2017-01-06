def organise(str)
  return (str.split /(?=[A-Z])/).join(" ").strip.gsub(" ", "-").downcase.gsub(/[0-9]/, "").gsub(/^-+/,'')
end
