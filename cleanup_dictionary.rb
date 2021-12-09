def cleanup_dictionary(dictionary)
  clean_dictionary = []
  File.open(dictionary, 'r').each { |line|
    line.chomp!
    clean_dictionary << line unless line.length < 5 || line.length > 12
  }
  clean_dictionary
end

# dictionary = 'dictionary.txt'
# File.open('clean_dictionary.txt', 'w') { |f| f.puts(cleanup_dictionary(dictionary)) }
