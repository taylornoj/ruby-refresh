puts "Text please: "
text = gets.chomp

# turn users string into something we can iterate over - calling split on text will turn it into an array
words = text.split(" ")

# 0 is the default value for the hash
frequencies = Hash.new(0)

#iterate over words to add each word to frequencies hash
words.each { |word| frequencies[word] += 1 }

# sort frequencies hash by word count and store results back in frequencies
# .sort_by returns an array of arrays
frequencies = frequencies.sort_by do |word, count|
  count
end

# use .reverse to reverse sorted frequencies array - more frequent words on top of list
frequencies.reverse!

frequencies.each { |word, frequency| puts word + " " + frequency.to_s }