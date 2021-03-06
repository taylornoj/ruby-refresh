# methods are reusable code - written to perform a specific task in a program

# separation of concerns - assigning specific tasks to separate methods
  # makes program less redundant and more reusable

# methods are defined using keyword def & then made up of 3 parts:
  # header - includes the def keyword, name of the method and any arguments
  # body - code block that describes the procedures
  # end - end keyword

# call a method by writing its name

def prime(n)
  puts "That's not an integer." unless n.is_a? Integer
  is_prime = true
  for i in 2..n-1
    if n % i == 0
      is_prime = false
    end
  end
  if is_prime
    puts "#{n} is prime!"
  else
    puts "#{n} is not prime."
  end
end

prime(2)
prime(9)
prime(11)
prime(51)
prime(97)