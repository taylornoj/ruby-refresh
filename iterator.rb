=begin
 a ruby method that repeatedly invokes a block of code

an example is the loop method:
  loop { print "Hello, world!" }
however this is infinite. the { } are interchangeable with keywords 'do'
and 'end' (to open and close the block)

=end

i = 20
loop do
  i -= 1
  print "#{i} "
  break if i <= 0
end