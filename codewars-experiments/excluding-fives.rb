def dont_give_me_five(start_,end_)
    (start_..end_).to_a.join(' ').split(" ").delete_if {|x| x.include?("5")}.count
end
