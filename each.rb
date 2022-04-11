=begin
 
the .each iterator: 
can apply an expression to each element of an object, one at a time

object.each { |item| 
  # Do something 
}

or

object.each do |item| 
  # Do something 
end

=end

array = [1,2,3,4,5]

array.each do |x|
  x += 10
  puts "#{x} "
end