=begin

Hash literal is within { key => value }

Hash.new is the samething just different syntax
ex. my_hash = Hash.new
=end

pets = Hash.new
# adds the key "Ellie" with value "dog"
pets["Ellie"] = "dog"
puts pets["Ellie"]