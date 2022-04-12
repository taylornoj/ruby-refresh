puts "Text to search through: "
text = gets.chomp
puts "Word to redact: "
redact = gets.chomp

# split method - takes in a string and returns an array
# if we pass it some text in parentheses, split will divide the string 
# whereever it sees that bit of text (a delimiter)
words = text.split(" ")

words.each do |word|
  if word != redact
    print word + " "
  else
    print "REDACTED "
  end
end