# Ruby's built in sorting library

my_array = [3, 4, 8, 7, 1, 6, 5, 9, 2]

# Call the sort! method on my_array below.
# my_array should then equal [1, 2, 3, 4, 5, 6, 7, 8, 9].

print my_array.sort!



books = ["Charlie and the Chocolate Factory", "War and Peace", "Utopia", "A Brief History of Time", "A Wrinkle in Time"]

# will sort alphabetically 
print books.sort!

# NOTE:
  # .sort returns a sorted array while leaving original array alone
  # .sort! modifies the actual array