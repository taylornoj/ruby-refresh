# can be used to skip over certain steps in the loop

# loop through range of 1 through 5 assigning each number to i
for i in 1..5
  # if remainder of 1/2 == 0, we go to enxt iteration of the loop
  next if i % 2 == 0
  print i # 1, 3, 5
end