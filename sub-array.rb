s = [["ham", "swiss"], ["turkey", "cheddar"], ["roast beef", "gruyere"]]

s.each { |sub_array| sub_array.each { |element| puts element} }

=begin
 prints:
ham
swiss
turkey
cheddar
roast beef
gruyere

iterates over sub arrays

=end