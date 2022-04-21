=begin

methods don't know how many arguments there will be sometimes

def friend(name):
  puts "My friend is " + name + "."
end

what if you want to print out all the user's friends, without knowing how many friend
names the user will put in ahead of time?

Solution is splat arguments - preceded by a * which tells the program that the
method can receive one or more arguments

=end