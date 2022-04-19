puts "Text please: "
text = gets.chomp

# turn users string into something we can iterate over - calling split on text will turn it into an array
words = text.split(" ")

# 0 is the default value for the hash
frequencies = Hash.new(0)

#iterate over words to add each word to frequencies hash
words.each { |word| frequencies[word] += 1 }
frequencies = frequencies.sort_by {|a, b| b }
frequencies.reverse!
frequencies.each { |word, frequency| puts word + " " + frequency.to_s }