menagerie = { :foxes => 2,
  :giraffe => 1,
  :weezards => 17,
  :elves => 1,
  :canaries => 4,
  :ham => 1
}

=begin

Symbols aren't strings:
"string" == :string   => false

Beyond syntax, there's a key behaviour of symbols that makes them different 
from strings.  While there can be multiple different strings that all have the same
value, there's only one copy of any particular symbol at a given time

=end

 # object_id method gets ID of an object

# the two "strings" are different objects while...
puts "string".object_id # 22151120
puts "string".object_id # 22150880

# :symbol is the same object listed twice
puts :symbol.object_id # 802268
puts :symbol.object_id # 802268

