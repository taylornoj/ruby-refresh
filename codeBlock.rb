=begin

A method can take a block as a parameter 

This is what .each has been doing - taking a block as a parameter 

 The block, {|i| puts i}, is passed the current
 array item each time it is evaluated. This block
 prints the item. 
[1, 2, 3, 4, 5].each { |i| puts i }

Passing a block to a method is a way of abstracting certain tasks from the method
and defining those tasks when we call the method

Abstracting is important in comp sci - it means to essentially make something simpler

=end