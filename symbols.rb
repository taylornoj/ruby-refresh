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