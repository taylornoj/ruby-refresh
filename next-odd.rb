# skip to the next iteration if the number i is odd

i = 20
loop do
  i -= 1
  next if i % 2 == 1
  puts "#{i}"
  break if i <= 0
end