=begin

What happens if you try to access a key that doesn't exist?

In many languages, you'll get an error but not in Ruby. You'll get special value nil

Along with false, nil is one of two non true values in Ruby.

False and nil are NOT the same thing: 
False means 'not true'
nil is Ruby's way of saying 'nothing at all'

=end

creatures = { "weasels" => 0,
  "puppies" => 6,
  "platypuses" => 3,
  "canaries" => 1,
  "Heffalumps" => 7,
  "Tiggers" => 1
}

puts creatures["weasels"]
# prints 0