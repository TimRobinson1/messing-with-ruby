def lineup_students(students)
  students.split(" ")
  .sort {|a,b| a <=> b}
  .sort_by(&:length).reverse
end
